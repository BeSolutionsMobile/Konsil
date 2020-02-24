// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let comfirmConsultation = try? newJSONDecoder().decode(ComfirmConsultation.self, from: jsonData)

import Foundation

// MARK: - ComfirmConsultation
struct ComfirmConsultation: Codable {
    let stats: Int
    let data: ConsultationDetails
}

// MARK: - DataClass
struct ConsultationDetails: Codable {
    let id: Int
    let title, details, doctor_name, patient_name: String
    let patient_id, doctor_id, date, status: String

}
