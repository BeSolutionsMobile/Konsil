// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let specialiteis = try? newJSONDecoder().decode(Specialiteis.self, from: jsonData)

import Foundation

// MARK: - Specialiteis
struct Specialiteis: Codable {
    let status: Int
    let data: [Speciality]
}

// MARK: - Datum
struct Speciality: Codable {
    let id: Int
    let image_url: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case image_url
        case title
    }
}
