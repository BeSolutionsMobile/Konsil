// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getAppointments = try? newJSONDecoder().decode(GetAppointments.self, from: jsonData)

import Foundation

// MARK: - GetAppointments
struct GetAppointments: Codable {
    let status: Int
    let data: [Appointments]
}

// MARK: - Datum
struct Appointments: Codable {
    let id: Int
    let time: String
}
