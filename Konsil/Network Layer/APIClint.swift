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
    private static func performRequest<T:Decodable>(route: APIRouter , decoder: JSONDecoder = JSONDecoder() , completion:@escaping (Result<T,AFError>)-> Void)-> DataRequest {
        return AF.request(route)
            .responseDecodable(decoder: decoder) { (response: DataResponse<T,AFError>) in
                completion(response.result)
        }
        
    }
    @discardableResult
    private static func performRequestSimple(route: APIRouter , completion:@escaping(Result<String,AFError>) -> Void ) ->DataRequest {
        return AF.request(route)
            .responseString( encoding: String.Encoding.utf8) { (response) in
                completion(response.result)
        }
    }
    
    //--------------------------------------------------------------------------------------
    
    static func register(name: String , email: String, password: String, phone: String, image_url: String, platform: Int, lang: String, mobile_tokken: String, completion: @escaping(Result<Register,AFError>)->Void) {
        performRequest(route: APIRouter.Register(name: name, phone: phone, email: email, password: password, platform: platform, image_url: image_url, lang: lang, mobile_token: mobile_tokken), completion: completion)
        
    }
}
