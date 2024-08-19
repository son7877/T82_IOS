enum Genre: Int, CaseIterable, Identifiable, Equatable {
    
    case concert = 1
    case musical = 2
    case sports = 3
    
    var id: Int { self.rawValue }
    
    var displayName: String {
        switch self {
        case .concert:
            return "콘서트"
        case .musical:
            return "뮤지컬"
        case .sports:
            return "스포츠"
        }
    }
    
    var subCategories: [SubCategory] {
        switch self {
        case .concert:
            return [
                SubCategory(id: 4, name: "대중가요"),
                SubCategory(id: 5, name: "발라드"),
                SubCategory(id: 6, name: "랩/힙합"),
                SubCategory(id: 7, name: "재즈/소울"),
                SubCategory(id: 8, name: "트로트"),
                SubCategory(id: 9, name: "내한공연"),
                SubCategory(id: 10, name: "인디"),
            ]
        case .musical:
            return [
                SubCategory(id: 11, name: "오리지널"),
                SubCategory(id: 12, name: "창작뮤지컬"),
            ]
        case .sports:
            return [
                SubCategory(id: 13, name: "야구"),
                SubCategory(id: 14, name: "축구"),
                SubCategory(id: 15, name: "E스포츠"),
                SubCategory(id: 16, name: "기타스포츠"),
            ]
        }
    }
}

struct SubCategory: Identifiable, Equatable{
    let id: Int
    let name: String
}
