import Foundation

struct MainEvents: Hashable, Decodable, Identifiable {
    
    let id: Int
//    var imageName: String
    var title: String
    var rating: Double
    
    enum CodingKeys: String, CodingKey {
            case id = "eventInfoId"
            case title
            case rating
    }
}
