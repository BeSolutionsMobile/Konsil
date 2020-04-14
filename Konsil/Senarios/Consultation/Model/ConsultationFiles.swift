// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let res = try? newJSONDecoder().decode(Res.self, from: jsonData)

import Foundation

// MARK: - Res
struct GetConsultationFiles: Codable {
    let status: Int
    let consultation: [ConsultationFiles]
}

// MARK: - Consultation
struct ConsultationFiles: Codable {
    let id: Int
    let url, name: String
}
