//
//  APIRouter.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/4/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    
    
    case Register(name: String ,phone: String ,email: String , password: String ,platform: Int ,image_url: String ,lang: String ,mobile_token: String)
    case Login(email: String ,password: String ,mobile_token: String)
    case AllSpecialities
    case SpecialityDoctors(speciality_id: Int)
    case FilterDoctors(speciality_id: Int ,degree_id: [Int] ,rate: Int)
    case DoctorDetails(doctor_id: Int)
    case ChangeLanguage(lang: String)

    //MARK:- HTTP Method
    private var method: HTTPMethod {
        switch self {
        case .Register:
            return .post
        case .Login:
            return .post
        case .AllSpecialities:
            return .get
        case .SpecialityDoctors:
            return .get
        case .FilterDoctors:
            return .post
        case .DoctorDetails:
            return .get
        case .ChangeLanguage:
            return .post
        }
    }
    
    //MARK:- Path
    private var path: String {
        switch self {
        case .Register:
            return "/auth/register"
        case .Login:
            return "/auth/login"
        case .AllSpecialities:
            return "/specialities"
        case .SpecialityDoctors:
            return "/speciality-doctors"
        case .FilterDoctors:
            return "/filter-doctors"
        case .DoctorDetails:
            return "/doctor-details"
        case .ChangeLanguage:
            return "/change-lang"
        }
    }
    
    
    private var parameters: Parameters? {
        switch self {
        case .Register(let name, let phone, let email, let password, let platform, let image_url, let lang, let mobile_token):
            return [K.Register.name: name, K.Register.phone: phone , K.Register.email: email , K.Register.password: password , K.Register.platform: platform , K.Register.image_url: image_url , K.Register.lang: lang , K.Register.mobile_token: mobile_token ]
        case .Login(let email , let password ,let mobile_token):
            return [K.Login.email: email ,K.Login.password: password ,K.Login.mobile_token: mobile_token]
        case .AllSpecialities:
            return nil
        case .SpecialityDoctors(let speciality_id):
            return [K.SpecialityDoctors.speciality_id: speciality_id]
        case .FilterDoctors(let speciality_id ,let degree_id ,let rate ):
            return [K.FilterDoctors.speciality_id: speciality_id , K.FilterDoctors.degree_id: degree_id , K.FilterDoctors.rate: rate]
        case .DoctorDetails(let doctor_id):
            return [K.DoctorDetails.doctor_id: doctor_id]
        case .ChangeLanguage(let lang):
            return [K.ChangeLanguage.lang: lang]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
       
      let url = try K.Server.baseURL.asURL()
       
      var urlRequest = URLRequest(url: url.appendingPathComponent(path))
       
      // HTTP Method
      urlRequest.httpMethod = method.rawValue
       
      // Common Headers
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HTTPHeaderField.contentType.rawValue)
        if let authToken = UserDefaults.standard.string(forKey: Key.authorizationToken) {
            urlRequest.setValue("Bearer " + authToken ,forHTTPHeaderField: K.HTTPHeaderField.authentication.rawValue)
        }
      // Parameters
      var encodedURLRequest:URLRequest? = nil
       
      var Vparameters: [String: Any]
       
      if(parameters == nil)
      {
        encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
      }else
      {
        Vparameters = parameters!
        encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: Vparameters)
      }
      return encodedURLRequest!
      }
}

