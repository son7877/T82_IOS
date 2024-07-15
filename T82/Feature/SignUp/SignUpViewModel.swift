//
//  SignUpViewModel.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

class SignUpViewModel: ObservableObject{
    @Published var signUpContent: SignUpContent
    
    init(
        signUpContent: SignUpContent = SignUpContent(
            email: "",
            password: "",
            passwordCheck: "",
            name: "",
            birthday: Date(),
            phoneNum: "",
            address: "",
            addressDetail: "")) {
        self.signUpContent = signUpContent
    }
}
