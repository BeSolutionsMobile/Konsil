// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let login = try? newJSONDecoder().decode(Login.self, from: jsonData)

import Foundation

// MARK: - Login
struct Login: Codable {
    let token: String
    let userInfo: User
}

//// MARK: - UserInfo
//struct UserInfo: Codable {
//    let id: Int
//    let name, code, email, mobile_token: String
//    let user_type_id: String
//    let image_url: String
//    let phone, lang: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, code, email
//        case mobile_token
//        case user_type_id
//        case image_url
//        case phone, lang
//    }
//}
