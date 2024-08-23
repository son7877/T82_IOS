import Foundation

struct EventsByDate: Decodable {
    
    let eventId: Int
    let eventStartTime: Date
    let eventSellCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case eventId, eventStartTime, eventSellCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try container.decode(Int.self, forKey: .eventId)
        let eventStartTimeString = try container.decode(String.self, forKey: .eventStartTime)
        eventSellCount = try container.decode(Int.self, forKey: .eventSellCount)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = formatter.date(from: eventStartTimeString) else {
            throw DecodingError.dataCorruptedError(forKey: .eventStartTime, in: container, debugDescription: "Date 형식 디코딩 에러")
        }
        eventStartTime = date
    }
}
