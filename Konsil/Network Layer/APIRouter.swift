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
    
    
    //MARK:- HTTP Method
    private var method: HTTPMethod {
        switch self {
        case .Register:
            return .post
        }
    }
    
    //MARK:- Path
    private var path: String {
        switch self {
        case .Register:
            return "/auth/register"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .Register(let name, let phone, let email, let password, let platform, let image_url, let lang, let mobile_token):
            return [K.Register.name: name, K.Register.phone: phone , K.Register.email: email , K.Register.password: password , K.Register.platform: platform , K.Register.image_url: image_url , K.Register.lang: lang , K.Register.mobile_token: mobile_token ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.Server.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters!)
        // Common Headers
        urlRequest.setValue(K.ContentType.json.rawValue , forHTTPHeaderField: K.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(K.ContentType.json.rawValue, forHTTPHeaderField: K.HTTPHeaderField.contentType.rawValue)
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        print("sasas" ,urlRequest)
        // Parameters
        var encodingURLRequest: URLRequest? = nil
        
        var Vparameters: [String: Any]
        
        if parameters == nil {
            encodingURLRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
        } else {
            Vparameters = parameters!
            encodingURLRequest = try URLEncoding.queryString.encode(urlRequest, with: Vparameters)
            print("dddd" ,encodingURLRequest)
        }
        
        return encodingURLRequest!
    }
}
