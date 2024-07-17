//
//  LoginResponse.swift
//  T82
//
//  Created by 안홍범 on 7/17/24.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let tokenType: String
}
