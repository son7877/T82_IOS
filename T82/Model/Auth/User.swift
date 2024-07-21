//
//  User.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

struct User : Hashable, Decodable{
    var email: String
    var password: String
    var passwordCheck: String
    var name: String
    var birthday: Date
    var phoneNumber: String
    var address: String
    var addressDetail: String
    
    init(email: String, password: String, passwordCheck: String, name: String, birthday: Date, phoneNumber: String, address: String, addressDetail: String) {
        self.email = email
        self.password = password
        self.passwordCheck = passwordCheck
        self.name = name
        self.birthday = birthday
        self.phoneNumber = phoneNumber
        self.address = address
        self.addressDetail = addressDetail
    }
}

struct UserInfo: Hashable, Decodable{
    var name: String
    var address: String
    var addressDetail: String
    var phoneNumber: String
    
    init(name: String, address: String, addressDetail: String, phoneNumber: String) {
        self.name = name
        self.address = address
        self.addressDetail = addressDetail
        self.phoneNumber = phoneNumber
    }
}
