// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myConsultations = try? newJSONDecoder().decode(MyConsultations.self, from: jsonData)

import Foundation

// MARK: - MyConsultations
struct MyConsultations: Codable {
    let status: String
    let data: [MyConsultation]
}

// MARK: - Datum
struct MyConsultation: Codable {
    let id: Int
    let price: String?
    let image: String
    let name: String
    let type: String
    let status: String
}

