// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let downloadReport = try? newJSONDecoder().decode(DownloadReport.self, from: jsonData)

import Foundation

// MARK: - DownloadReport
struct DownloadReport: Codable {
    let status: Int
    let report: Report?
}

// MARK: - Consultation
struct Report: Codable {
    let id: Int
    let url: String
}
