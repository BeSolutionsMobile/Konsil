//
//  APIClient.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/4/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError> , Int)->Void) -> DataRequest {
      return AF.request(route)
        .responseDecodable (decoder: decoder){
          (response: DataResponse<T,AFError>) in
            completion(response.result , response.response?.statusCode ?? 0)
      }
    }
    @discardableResult
    private static func performRequestSimple(route:APIRouter, completion: @escaping (Result<String, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseString(encoding: String.Encoding.utf8) {
                (response) in
                completion(response.result)
        }
    }
    //--------------------------------------------------------------------------------------
    
    static func register(name: String , email: String, password: String, phone: String, image_url: String, platform: Int, lang: String, mobile_tokken: String, completion: @escaping(Result<Register,AFError> , Int)->Void) {
        performRequest(route: APIRouter.Register(name: name, phone: phone, email: email, password: password, platform: platform, image_url: image_url, lang: lang, mobile_token: mobile_tokken), completion: completion)
        
    }
    
    static func login(email: String, password: String, mobile_tokken: String, completion: @escaping(Result<Login,AFError>, Int)->Void) {
        performRequest(route: APIRouter.Login(email: email, password: password, mobile_token: mobile_tokken), completion: completion)
    }
    
    static func allSpeciailies(completion: @escaping(Result<Specialiteis,AFError>, Int)->Void){
        performRequest(route: APIRouter.AllSpecialities, completion: completion)
    }
    
    static func specialityDoctors(speciality_id: Int ,completion: @escaping(Result<SpecialityDoctors,AFError>, Int)->Void){
        performRequest(route: APIRouter.SpecialityDoctors(speciality_id: speciality_id), completion: completion)
    }
    
    static func filterDoctors(speciality_id: Int ,degree_id: [Int] ,rate: Int ,completion: @escaping(Result<FilteredDoctors,AFError>, Int)->Void){
        performRequest(route: APIRouter.FilterDoctors(speciality_id: speciality_id, degree_id: degree_id, rate: rate), completion: completion)
    }

    static func changeLanguage(lang: String ,completion: @escaping(Result<Language,AFError>, Int)->Void){
        performRequest(route: APIRouter.ChangeLanguage(lang: lang), completion: completion)
    }
}
