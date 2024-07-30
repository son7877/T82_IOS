import Foundation

struct MainContents: Hashable, Decodable, Identifiable {
    
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

struct EventResponse: Decodable {
    let totalPages: Int
    let totalElements: Int
    let first: Bool
    let last: Bool
    let size: Int
    let content: [MainContents]
    let number: Int
    let sort: Sort
    let numberOfElements: Int
    let pageable: Pageable
    let empty: Bool
    
    struct Sort: Decodable {
        let empty: Bool
        let sorted: Bool
        let unsorted: Bool
    }
    
    struct Pageable: Decodable {
        let pageNumber: Int
        let pageSize: Int
        let sort: Sort
        let offset: Int
        let paged: Bool
        let unpaged: Bool
    }
}

