import Foundation

struct Refund: Hashable, Encodable {
    let orderNo: String
    let seatId: Int
    let amount: Int
    var reason: String
}
