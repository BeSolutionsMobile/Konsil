// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fAQ = try? newJSONDecoder().decode(FAQ.self, from: jsonData)

import Foundation

// MARK: - FAQ
struct FAQ: Codable {
    let status: Int
    let data: [Questions]
}

// MARK: - Datum
struct Questions: Codable {
    let id: Int
    let question, answer: String
}
