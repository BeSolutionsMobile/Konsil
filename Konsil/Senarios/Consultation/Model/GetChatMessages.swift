// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getChatMessages = try? newJSONDecoder().decode(GetChatMessages.self, from: jsonData)

import Foundation

// MARK: - GetChatMessages
struct GetChatMessages: Codable {
    let status: Int
    let messages: [MessageInfo]
}

// MARK: - Message
struct MessageInfo: Codable {
    let id: Int
    let name: String
    let user_image: String
    let message: String
}
