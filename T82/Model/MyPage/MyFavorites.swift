import Foundation

struct MyFavorites: Hashable, Decodable, Identifiable {
    let eventInfoId: Int
    let title: String
    let bookStartTime: Date
    
    var id: Int {
        return eventInfoId
    }
}
