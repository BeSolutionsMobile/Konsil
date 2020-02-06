//
//  Constants.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/4/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import Foundation

struct K {
    
    struct Server {
        static let baseURL = "https://www.konsilmed.com/api"
    }
    
    struct Register {
        static let name = "name"
        static let email = "email"
        static let phone = "phone"
        static let password = "password"
        static let image_url = "image_url"
        static let mobile_token = "mobile_token"
        static let lang = "lang"
        static let platform = "platform"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    enum ContentType: String {
        case json = "application/json"
    }

    
}
