// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addConsultation = try? newJSONDecoder().decode(AddConsultation.self, from: jsonData)

import Foundation

// MARK: - AddConsultation
struct AddConsultation: Codable {
    let status: Int
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let title, details: String
    let patient_id: Int
    let doctor_id: String
    let status_id, type: Int
    let updated_at, created_at: String
    let id: Int

}
