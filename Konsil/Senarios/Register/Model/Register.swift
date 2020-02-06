// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let register = try? newJSONDecoder().decode(Register.self, from: jsonData)

import Foundation

// MARK: - Register
struct Register: Codable {
    let token: String
    let userInfo: UserInfo
}

// MARK: - UserInfo
struct UserInfo: Decodable , Encodable {
    let name, code, email, mobileToken: String
    let userTypeID, lang: String
    let imageURL, phone: String?
    enum CodingKeys: String, CodingKey {
        case name, code, email
        case mobileToken
        case userTypeID
        case imageURL
        case phone, lang
    }
}
