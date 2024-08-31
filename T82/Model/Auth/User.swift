import Foundation
import FirebaseAuth

struct User : Hashable, Decodable{
    var email: String
    var password: String
    var passwordCheck: String
    var name: String
    var birthDate: Date
    var phoneNumber: String
    var address: String
    var addressDetail: String
    
    init(email: String, password: String, passwordCheck: String, name: String, birthDate: Date, phoneNumber: String, address: String, addressDetail: String) {
        self.email = email
        self.password = password
        self.passwordCheck = passwordCheck
        self.name = name
        self.birthDate = birthDate
        self.phoneNumber = phoneNumber
        self.address = address
        self.addressDetail = addressDetail
    }
}

struct LoginContent : Hashable, Decodable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct SignUpContent: Hashable, Encodable {
    var email: String
    var password: String
    var passwordCheck: String
    var name: String
    var birthDate: Date
    var phoneNumber: String
    var address: String
    var addressDetail: String
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password, passwordCheck, name, birthDate, phoneNumber, address, addressDetail,imageUrl
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(passwordCheck, forKey: .passwordCheck)
        try container.encode(name, forKey: .name)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDateString = dateFormatter.string(from: birthDate)
        try container.encode(birthDateString, forKey: .birthDate)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(address, forKey: .address)
        try container.encode(addressDetail, forKey: .addressDetail)
        try container.encode(imageUrl, forKey: .imageUrl)
    }
}








