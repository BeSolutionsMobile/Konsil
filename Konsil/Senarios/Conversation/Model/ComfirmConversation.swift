// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let comfirmConversation = try? newJSONDecoder().decode(ComfirmConversation.self, from: jsonData)

import Foundation

// MARK: - ComfirmConversation
struct ComfirmConversation: Codable {
    let stats: Int
    let data: ConversationDetails
}

// MARK: - DataClass
struct ConversationDetails: Codable {
    let id: Int
    let doctor, date, conversation_link, status: String
}
