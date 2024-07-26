import Foundation

struct Seat: Hashable, Decodable {
    let id: Int
    let rowNum: Int
    let colNum: Int
    let name: String // Section 이름
    var isSelected: Bool
    var isAvailable: Bool
}

struct RestSeats: Decodable, Hashable{
    let sectionId : Int
    let name : String
    let restSeat : Int
}

struct SelectableSeat: Decodable, Hashable, Identifiable {
    let seatId: Int
    let rowNum: Int
    let colNum: Int
    let name: String // Section 이름
    let price: Int
    
    var id: Int {
        return seatId
    }
}

struct PendingSeat : Decodable, Hashable {
    let seatId: Int
    let eventId: Int
    let price : Int
}
