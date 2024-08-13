import Foundation

struct UserInfo: Hashable, Decodable {
    var name: String
    var email: String
    var birthDate: Date
    var address: String
    var addressDetail: String
    var phoneNumber: String
    var profileUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case email
        case birthDate
        case address
        case addressDetail
        case phoneNumber
        case profileUrl
    }
    
    init(name: String, email: String, birthDate: Date, address: String, addressDetail: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.birthDate = birthDate
        self.address = address
        self.addressDetail = addressDetail
        self.phoneNumber = phoneNumber
        self.profileUrl = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        addressDetail = try container.decode(String.self, forKey: .addressDetail)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        profileUrl = try container.decodeIfPresent(String.self, forKey: .profileUrl)
        
        let birthDateString = try container.decode(String.self, forKey: .birthDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: birthDateString) {
            birthDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .birthDate, in: container, debugDescription: "날짜 형식 에러")
        }
    }
}
