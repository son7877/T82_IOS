import Foundation

struct Sections: Hashable{
    var sectionId: Int
    var name: String
    var totalSeat: Int
    var restSeat: Int
    var price: Int
    var eventId: Int
    
    init(sectionId: Int, name: String, totalSeat: Int, restSeat: Int, price: Int, eventId: Int) {
        self.sectionId = sectionId
        self.name = name
        self.totalSeat = totalSeat
        self.restSeat = restSeat
        self.price = price
        self.eventId = eventId
    }
}
