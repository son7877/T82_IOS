import Foundation

struct EventInfoReviews: Hashable, Decodable, Identifiable {
    
    let reviewId: Int
    let eventInfoId: Int
    let content: String
    let rating: Double
    let reviewPictureUrl: String?
    let createDate: String
    let userId: String
    let userImage: String?
    let username: String
    let isArtist: Bool
    
    var id: Int{
        return reviewId
    }
}

struct Replies: Hashable, Decodable, Identifiable {
    
    let commentId: Int
    let content: String
    let isDeleted: Bool
    let createDate: String
    let userId: String
    let userImage: String?
    let username: String
    let isArtist: Bool
    
    var id: Int{
        return commentId
    }
}
