// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let specialityDoctors = try? newJSONDecoder().decode(SpecialityDoctors.self, from: jsonData)

import Foundation

// MARK: - SpecialityDoctors
struct SpecialityDoctors: Codable {
    let status: Int
    let doctors: [Doctor]
    let degrees: [Degree]
}

// MARK: - Degree
struct Degree: Codable {
    let id: Int
    let degree: String
}

// MARK: - Doctor
struct Doctor: Codable {
    let id: Int
    let degree, name: String
    let image_url: String
    let rate: String

}

