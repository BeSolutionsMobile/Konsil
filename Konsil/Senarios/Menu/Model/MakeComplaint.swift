// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let makeComplaint = try? newJSONDecoder().decode(MakeComplaint.self, from: jsonData)

import Foundation

// MARK: - MakeComplaint
struct MakeComplaint: Codable {
    let status: Int
    let message: String
}
