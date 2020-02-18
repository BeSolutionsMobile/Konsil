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
    case FAQ
    case changePersonalInfo(name: String ,phone: String ,email: String , password: String ,image_url: String )
    case AddConsultation(title: String ,details: String ,doctor_id: Int ,images: [String] ,files: [String])
    case ConsultationFiles(consultation_id: Int)
    case DownloadReport(consultation_id: Int)
    case GetAppointments(doctor_id: Int ,date: String)
    case ReserveConversation(doctor_id: Int ,appointment_id: Int)
    case ComplaintTypes
    case MakeComplaint(type_id: Int ,complaint: String)
    case MyConsultations
    
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
            return .post
        case .FilterDoctors:
            return .post
        case .DoctorDetails:
            return .post
        case .ChangeLanguage:
            return .post
        case .FAQ:
            return .get
        case .changePersonalInfo:
            return .post
        case .AddConsultation:
            return .post
        case .ConsultationFiles:
            return .get
        case .DownloadReport:
            return .get
        case .GetAppointments:
            return .post
        case .ReserveConversation:
            return .post
        case .ComplaintTypes:
            return .get
        case .MakeComplaint:
            return .post
        case .MyConsultations:
            return .get
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
        case .FAQ:
            return "/faq"
        case .changePersonalInfo:
            return "/update-user-info"
        case .AddConsultation:
            return "/add-consultation"
        case .ConsultationFiles:
            return "/consultation-files"
        case .DownloadReport:
            return "/download-report"
        case .GetAppointments:
            return "/get-date"
        case .ReserveConversation:
            return "/reserve-conversation"
        case .ComplaintTypes:
            return "/get-complaint-type"
        case .MakeComplaint:
            return "/make-complaint"
        case .MyConsultations:
            return "/my-consultations"
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
        case .FAQ:
            return nil
        case .changePersonalInfo(let name, let phone, let email, let password, let image_url):
            return [K.ChangeUserInfo.name: name ,K.ChangeUserInfo.phone: phone ,K.ChangeUserInfo.password: password ,K.ChangeUserInfo.email: email ,K.ChangeUserInfo.image_url: image_url]
        case .AddConsultation(let title, let details, let doctor_id, let images, let files):
            return [K.AddConsultation.title: title ,K.AddConsultation.details: details ,K.AddConsultation.doctor_id: doctor_id , K.AddConsultation.images: images ,K.AddConsultation.files: files]
        case .ConsultationFiles(let consultation_id):
            return [K.ConsultationFiles.consultation_id: consultation_id]
        case .DownloadReport(let consultation_id):
            return [K.DownloadReport.consultation_id: consultation_id]
        case .GetAppointments(let doctor_id, let date):
            return [K.GetApppointments.doctor_id: doctor_id , K.GetApppointments.date: date]
        case .ReserveConversation(let doctor_id, let appointment_id):
            return [K.ReserveConsultation.doctor_id: doctor_id , K.ReserveConsultation.appointment_id: appointment_id]
        case .ComplaintTypes:
            return nil
        case .MakeComplaint(let type_id, let complaint):
            return [K.MakeComplaint.type_id: type_id , K.MakeComplaint.Complaint: complaint]
        case .MyConsultations:
            return nil
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
        print(encodedURLRequest)
        return encodedURLRequest!
    }
}

