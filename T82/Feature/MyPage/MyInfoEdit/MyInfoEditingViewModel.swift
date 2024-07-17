//
//  MyInfoEditingViewModel.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

class MyInfoEditingViewModel: ObservableObject {
    @Published var user: User
    
    init(user:User = User(
        email: "",
        password: "",
        passwordCheck: "",
        nickName: "",
        birthday: Date(),
        phoneNum: "",
        address: "",
        addressDetail: "")) {
        self.user = user
    }
}
