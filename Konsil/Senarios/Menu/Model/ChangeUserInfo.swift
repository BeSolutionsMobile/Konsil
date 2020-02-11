// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let changeUserInfo = try? newJSONDecoder().decode(ChangeUserInfo.self, from: jsonData)

import Foundation

// MARK: - ChangeUserInfo
struct ChangeUserInfo: Codable {
    let status: Int
    let userInfo: User
}
