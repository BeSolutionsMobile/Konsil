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
        static let baseURL = "https://www.konsilmed.be4maps.com/api"
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
    
    struct Login {
        static let email = "email"
        static let password = "password"
        static let mobile_token = "mobile_token"
    }
    struct AllSpecialities {
    }
    
    struct SpecialityDoctors {
        static let speciality_id = "speciality_id"
    }
    
    struct FilterDoctors {
        static let speciality_id = "speciality_id"
        static let degree_id = "degree_id"
        static let rate = "rate"
    }
    
    struct DoctorDetails {
        static let doctor_id = "doctor_id"
    }
    
    struct ChangeLanguage {
        static let lang = "lang"
    }
    
    struct ChangeUserInfo {
        static let name = "name"
        static let email = "email"
        static let phone = "phone"
        static let password = "password"
        static let image_url = "image_url"
    }
    
    struct FAQ {
    }
    
    struct ChangePersonalInfo{
        static let name = "name"
        static let phone = "phone"
        static let email = "eamil"
        static let password = "password"
        static let image_url = "image_url"

    }
    
    //-----------------------------------------------
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
