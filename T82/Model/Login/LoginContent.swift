//
//  LoginContent.swift
//  T82
//
//  Created by 안홍범 on 7/11/24.
//

import Foundation

struct LoginContent : Hashable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
