import Foundation

struct PaymentRequest: Encodable {
    let totalAmount: Int
    let eventId: Int
    let items: [PaymentItem]
}

struct PaymentItem: Encodable {
    let seatId: Int
    let couponIds: [String]?
    let beforeAmount: Int?
    let amount: Int
}

struct PaymentResponse: Decodable {
    let success: Bool
    let message: String?
    let paymentURL: String?
}


