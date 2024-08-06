import Foundation

struct MyReview: Hashable, Identifiable, Codable{
    
    let eventInfoId: Int
    let content: String
    let rating: Int
    let reviewPictureUrl: String?
    var createdDate: String
    
    var id: Int {
        return eventInfoId
    }
}
