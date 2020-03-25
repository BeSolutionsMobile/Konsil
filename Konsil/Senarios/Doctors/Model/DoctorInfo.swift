// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let doctorInfo = try? newJSONDecoder().decode(DoctorInfo.self, from: jsonData)

import Foundation

// MARK: - DoctorInfo
struct DoctorInfo: Codable {
    let status: Int
    let doctor: DoctorData
}

// MARK: - Doctor
struct DoctorData: Codable {
    let id: Int
    let name: String
    let total_consultation, total_conversation: Int
    let degree, specialist: String
    let image_url, rate: String
    let bio ,job_title ,consultation_price ,conversation_price : String?

}
