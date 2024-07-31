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
    
    var id: Int {
        return ticketId
    }
}

struct MyTicketResponse: Codable {
    let totalPages: Int
    let totalElements: Int
    let first: Bool
    let last: Bool
    let size: Int
    let content: [MyTicket]
    let number: Int
    let numberOfElements: Int
    let pageable: MyTicketPageable
    let empty: Bool
    let sort: [MyTicketSort]
}

struct MyTicketPageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [MyTicketSort]
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}

struct MyTicketSort: Codable {
    let direction: String
    let property: String
    let ignoreCase: Bool
    let nullHandling: String
    let ascending: Bool
    let descending: Bool
}
