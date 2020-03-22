// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let register = try? newJSONDecoder().decode(Register.self, from: jsonData)

import Foundation

// MARK: - Register
struct Register: Codable {
    let token: String
    let userInfo: User
}

// MARK: - UserInfo
struct User: Codable {
    let id: Int
    let name, code, email, mobile_token: String
    let user_type_id, lang: String
    let image_url ,phone: String?
}
