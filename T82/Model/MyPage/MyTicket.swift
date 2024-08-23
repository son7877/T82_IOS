import Foundation

struct MyTicket: Hashable, Codable, Identifiable {
    
    let ticketId: Int
    let eventInfoId: Int
    let userId: String
    let seatId: Int
    let sectionName: String
    let rowNum: Int
    let columnNum: Int
    let isRefund: Bool
    let eventName: String
    let eventStartTime: String
    let paymentDate: String
    let paymentAmount: Int
    let orderNum: String
    let qrCodeUrl: String?
    let imageUrl: String
    
    var id: Int {
        return ticketId
    }
}
