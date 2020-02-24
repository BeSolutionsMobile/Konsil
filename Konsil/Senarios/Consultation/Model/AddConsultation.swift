// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addConsultation = try? newJSONDecoder().decode(AddConsultation.self, from: jsonData)

import Foundation

// MARK: - AddConsultation
struct AddConsultation: Codable {
    let status ,id: Int
    let message: String
}
