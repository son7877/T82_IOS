//
//  User.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

struct User : Hashable{
    var email: String
    var password: String
    var passwordCheck: String
    var nickName: String
    var birthday: Date
    var phoneNum: String
    var address: String
    var addressDetail: String
    
    init(email: String, password: String, passwordCheck: String, nickName: String, birthday: Date, phoneNum: String, address: String, addressDetail: String) {
        self.email = email
        self.password = password
        self.passwordCheck = passwordCheck
        self.nickName = nickName
        self.birthday = birthday
        self.phoneNum = phoneNum
        self.address = address
        self.addressDetail = addressDetail
    }
}
