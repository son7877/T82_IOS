import Foundation

struct Seat: Hashable, Codable {
    let id: Int
    let rowNum: Int
    let colNum: Int
    let name: String // Section 이름
    var isSelected: Bool
    var isAvailable: Bool
}

struct RestSeats: Codable, Hashable{
    let sectionId : Int
    let name : String
    let restSeat : Int
}

struct SelectableSeat: Codable, Hashable, Identifiable {
    let seatId: Int
    let rowNum: Int
    let colNum: Int
    let name: String
    let price: Int
    
    var id: Int {
        return seatId
    }
}

struct PendingSeat : Codable, Hashable {
    let seatId: Int
    let eventId: Int
    let price : Int
}
