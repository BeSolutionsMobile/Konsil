// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getConversationDetails = try? newJSONDecoder().decode(GetConversationDetails.self, from: jsonData)

import Foundation

// MARK: - GetConversationDetails
struct GetConversationDetails: Codable {
    let status: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let doctor, date, time, conversation_link: String
    let status: String
}
