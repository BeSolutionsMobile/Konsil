//
//  Constants.swift
//  Konsil
//
//  Created by Ali Mohamed on 2/4/20.
//  Copyright © 2020 begroup. All rights reserved.
//

import Foundation

struct K {
    
    struct Server {
        static let baseURL = "https://www.konsilmed.com/api"
    }
    
    struct Register {
        static let name = "name"
        static let email = "email"
        static let phone = "phone"
        static let password = "password"
        static let image_url = "image_url"
        static let mobile_token = "mobile_token"
        static let lang = "lang"
        static let platform = "platform"
    }
    
    struct Login {
        static let email = "email"
        static let password = "password"
        static let mobile_token = "mobile_token"
    }
    struct AllSpecialities {
    }
    
    struct SpecialityDoctors {
        static let speciality_id = "speciality_id"
    }
    
    struct FilterDoctors {
        static let speciality_id = "speciality_id"
        static let degree_id = "degree_id"
        static let rate = "rate"
    }
    
    struct DoctorDetails {
        static let doctor_id = "doctor_id"
    }
    
    struct ChangeLanguage {
        static let lang = "lang"
    }
    
    struct ChangePersonalInfo{
        static let name = "name"
        static let phone = "phone"
        static let email = "email"
        static let password = "password"
        static let image_url = "image_url"
        static let medical_history = "medical_history"
    }
    
    struct AddConsultation {
        static let title = "title"
        static let details = "details"
        static let doctor_id = "doctor_id"
        static let images = "images"
        static let files = "files"
    }
    
    struct ConsultationFiles {
        static let consultation_id = "consultation_id"
    }
    
    struct DownloadReport {
        static let consultation_id = "consultation_id"
    }
    
    struct GetApppointments {
        static let doctor_id = "doctor_id"
        static let date = "date"
    }
    
    struct ReserveConsultation {
        static let doctor_id = "doctor_id"
        static let appointment_id = "appointment_id"
    }
    
    struct ComfirmConsultation {
        static let consultation_id = "consultation_id"
        static let payment_status = "payment_status"
    }
    
    struct ComfirmConversation {
        static let consultation_id = "consultation_id"
        static let payment_status = "payment_status"
    }
    
    struct ComplaintTypes {
    }
    
    struct MakeComplaint {
        static let type_id = "type_id"
        static let Complaint = "complaint"
        static let consultation_id = "consultation_id"
    }
    
    struct MyConsultations {
    }
    
    struct GetChatMessages {
        static let consultation_id = "consultation_id"
    }
    
    struct SendMessage {
        static let consultation_id = "consultation_id"
        static let message = "message"
    }
    
    struct GetConversationDetails {
        static let conversation_id = "conversation_id"
    }
    
    struct UploadConsultationFiles {
        static let consultation_id = "consultation_id"
        static let images = "images"
        static let files = "files"
    }
    
    struct GetStripeToken {
        static let amount = "amount"
    }
    //-----------------------------------------------
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    enum ContentType: String {
        case json = "application/json"
    }
    
}
