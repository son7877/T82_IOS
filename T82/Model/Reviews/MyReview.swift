import Foundation

struct MyReview: Hashable, Identifiable, Decodable{
    
    let reviewId: Int
    let eventInfoId: Int
    let content: String
    let rating: Double
    let reviewPictureUrl: String?
    let createdDate: String
    let userId: String
    let userImage: String?
    let userName: String
    let isArtist: Bool
    
    var id: Int {
        return reviewId
    }
}

struct MyReviewRequest: Codable {
    let eventInfoId: Int
    let content: String
    let rating: Double
    var reviewPictureUrl: String?
}
