// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getConsultationFiles = try? newJSONDecoder().decode(GetConsultationFiles.self, from: jsonData)

import Foundation

// MARK: - GetConsultationFiles
struct GetConsultationFiles: Codable {
    let status: Int
    let consultation: ConsultationFiles
}

// MARK: - Consultation
struct ConsultationFiles: Codable {
    let id: Int
    let files: [String]
}
