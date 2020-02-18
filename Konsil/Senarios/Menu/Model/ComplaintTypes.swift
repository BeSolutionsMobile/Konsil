// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let complaintTypes = try? newJSONDecoder().decode(ComplaintTypes.self, from: jsonData)

import Foundation

// MARK: - ComplaintTypes
struct ComplaintTypes: Codable {
    let status: Int
    let data: [Complaint ]
}

// MARK: - Datum
struct Complaint: Codable {
    let id: Int
    let title: String
}
