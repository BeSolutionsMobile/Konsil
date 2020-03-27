//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let doctorInfo = try? newJSONDecoder().decode(DoctorInfo.self, from: jsonData)
//
//import Foundation
//
//// MARK: - DoctorInfo
//struct DoctorInfo: Codable {
//    let status: Int
//    let doctor: DoctorData
//}
//
//// MARK: - Doctor
//struct DoctorData: Codable {
//    let id: Int
//    let name: String
//    let total_consultation, total_conversation: Int
//    let degree, specialist: String
//    let image_url, rate ,lang: String
//    let bio ,job_title ,consultation_price ,conversation_price : String?
//
//}
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let res = try? newJSONDecoder().decode(Res.self, from: jsonData)

import Foundation

// MARK: - Res
struct DoctorInfo: Codable {
    let status: Int
    let doctor: DoctorData
}

// MARK: - Doctor
struct DoctorData: Codable {
    let id: Int
    let name, total_consultation, total_conversation, consultation_price: String
    let conversation_price, degree, specialist : String
    let lang, rate: String
    let image_url: String
    let bio, job_title: String?
}
