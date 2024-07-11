//
//  SignUpView.swift
//  T82
//
//  Created by 안홍범 on 7/8/24.
//

import SwiftUI

struct SignUpView: View {
    
    @FocusState private var isFocused: Bool
    @State private var user: User = User(email: "", password: "", passwordCheck: "", name: "", birthday: Date(), phoneNum: "", address: "", addressDetail: "")
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        CustomNavigationBar( // 커스텀 네비게이션 바 사용 방법
            isDisplayLeftBtn: true,
            isDisplayRightBtn: false,
            isDisplayTitle: true,
            leftBtnAction: {
                presentationMode.wrappedValue.dismiss()
            },
            rightBtnAction: {},
            lefttBtnType: .back,
            rightBtnType: .mylike,
            Title: "회원 가입"
        )
        .padding()
        
        ScrollView{
            VStack
            {
                TextField("이메일", text: $user.email)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                SecureField("비밀번호", text: $user.password)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                SecureField("비밀번호 확인", text: $user.passwordCheck)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                TextField("이름", text: $user.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                DatePicker("생년월일", selection: $user.birthday, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .environment(\.locale, Locale.init(identifier: "ko_KR"))
                
                TextField("휴대폰 번호", text: $user.phoneNum)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                TextField("주소", text: $user.address)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                TextField("상세 주소", text: $user.addressDetail)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        
        Button(
            action: {
                // 회원가입 완료 통신
            },
            label: {
                Text("회원가입")
            }
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.customOrange)
        .foregroundColor(.white)
        .cornerRadius(20)

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
