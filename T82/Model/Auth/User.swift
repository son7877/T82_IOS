import Foundation

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


