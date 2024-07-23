import Foundation

struct DiscountedContents: Hashable, Decodable {
    let eventId: Int
//    var imageName: String
    var title: String
    var rating: Double
    var discountRate: Double
    var discountedPrice: Int
    
    init(
        eventId: Int,
//        imageName: String,
        title: String,
        rating: Double,
        discountRate: Double,
        discountedPrice: Int) {
        self.eventId = eventId
//        self.imageName = imageName
        self.title = title
        self.rating = rating
        self.discountRate = discountRate
        self.discountedPrice = discountedPrice
    }
}
