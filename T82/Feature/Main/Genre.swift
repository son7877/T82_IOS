enum Genre: Int, CaseIterable, Identifiable {
    
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
                SubCategory(id: 4, name: "오리지널/내한"),
                SubCategory(id: 5, name: "라이선스"),
                SubCategory(id: 6, name: "창작뮤지컬"),
                SubCategory(id: 7, name: "넌버벌퍼포먼스")
            ]
        case .musical:
            return [
                SubCategory(id: 8, name: "발라드"),
                SubCategory(id: 9, name: "락/메탈"),
                SubCategory(id: 10, name: "랩/힙합"),
                SubCategory(id: 11, name: "재즈/소울"),
                SubCategory(id: 12, name: "디너쇼"),
                SubCategory(id: 13, name: "포크/트로트"),
                SubCategory(id: 14, name: "내한공연"),
                SubCategory(id: 15, name: "페스티벌"),
                SubCategory(id: 16, name: "팬클럽/팬미팅"),
                SubCategory(id: 17, name: "인디"),
                SubCategory(id: 18, name: "토크/강연")
            ]
        case .sports:
            return [
                SubCategory(id: 19, name: "야구"),
                SubCategory(id: 20, name: "축구"),
                SubCategory(id: 21, name: "프리미어리그"),
                SubCategory(id: 22, name: "e스포츠")
            ]
        }
    }
}

struct SubCategory: Identifiable, Equatable{
    let id: Int
    let name: String
}
