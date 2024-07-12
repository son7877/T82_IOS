//
//  MyInfoEditing.swift
//  T82
//
//  Created by 안홍범 on 7/12/24.
//

import SwiftUI

struct MyInfoEditingView: View {
    
    @FocusState private var isFocused: Bool
    @State private var user: User = User(email: "", password: "", passwordCheck: "", name: "", birthday: Date(), phoneNum: "", address: "", addressDetail: "")
    @Environment(\.presentationMode) var presentationMode
    @State private var passwordValidationMessage: String = ""
    @State private var passwordCheckValidationMessage: String = ""
    
    var body: some View {
        VStack{
            Divider()
                .frame(height:2)
                .background(.customGray1)
                .padding(.horizontal, 30)

            HStack(spacing: 30){
                Text("이름(닉네임)")
                    .font(.system(size: 13))
                
                TextField("",text: $user.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 60){
                Text("이메일")
                    .font(.system(size: 13))
                
                TextField("",text: $user.email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50){
                Text("생년월일")
                    .font(.system(size: 13))
                
                DatePicker("", selection: $user.birthday, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .environment(\.locale, Locale.init(identifier: "ko_KR"))
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50){
                Text("비밀번호")
                    .font(.system(size: 13))
                
                SecureField("",text: $user.password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .onChange(of: user.password) { newValue, _ in
                        passwordValidationMessage = Validation.validatePassword(newValue)
                        passwordCheckValidationMessage = Validation.validatePasswordCheck(password: newValue, passwordCheck: user.passwordCheck)
                    }
            }
            
            if !passwordValidationMessage.isEmpty {
                Text(passwordValidationMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding([.leading, .trailing], 10)
                    .frame(width: 300, alignment: .leading)
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 25){
                Text("비밀번호 확인")
                    .font(.system(size: 13))
                
                SecureField("",text: $user.passwordCheck)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .onChange(of: user.passwordCheck) { newValue, _ in
                        passwordCheckValidationMessage = Validation.validatePasswordCheck(password: user.password, passwordCheck: newValue)
                    }
            }
            
            if !passwordCheckValidationMessage.isEmpty {
                Text(passwordCheckValidationMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding([.leading, .trailing], 15)
                    .frame(width: 300, alignment: .leading)
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50){
                Text("전화번호")
                    .font(.system(size: 13))
                
                TextField("",text: $user.phoneNum)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 70){
                Text("주소")
                    .font(.system(size: 13))
                
                TextField("",text: $user.address)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50){
                Text("상세주소")
                    .font(.system(size: 13))
                
                TextField("",text: $user.addressDetail)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            
            
            
            
            
        }
    }
}

#Preview {
    MyInfoEditingView()
}