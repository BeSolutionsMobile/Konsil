import Foundation

struct StripeToken: Codable {
    let status: Int
    let client_secret: String
}
