// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reserverConversation = try? newJSONDecoder().decode(ReserverConversation.self, from: jsonData)

import Foundation

// MARK: - ReserverConversation
struct ReserverConversation: Codable {
    let status: Int
    let data: ConversationInfo
}

// MARK: - DataClass
struct ConversationInfo: Codable {
    let id: Int
    let doctor, date, conversation_link, status: String
}
