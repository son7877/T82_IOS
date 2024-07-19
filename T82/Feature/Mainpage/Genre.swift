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
}
