import SwiftUI

struct MyInfoEditingView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject private var viewModel = MyInfoEditingViewModel()
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
                    
                    TextField("",text: $viewModel.user.nickName)
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
                    
                    TextField("",text: $viewModel.user.email)
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
                    
                    DatePicker("", selection: $viewModel.user.birthday, displayedComponents: .date)
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
                    
                    SecureField("",text: $viewModel.user.password)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 0)
                        .frame(width: 220, height: 40)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.user.password) { newValue, _ in
                            passwordValidationMessage = Validation.validatePassword(newValue)
                            passwordCheckValidationMessage = Validation.validatePasswordCheck(password: newValue, passwordCheck: viewModel.user.passwordCheck)
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
                    
                    SecureField("",text: $viewModel.user.passwordCheck)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 0)
                        .frame(width: 220, height: 40)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.user.passwordCheck) { newValue, _ in
                            passwordCheckValidationMessage = Validation.validatePasswordCheck(password: viewModel.user.password, passwordCheck: newValue)
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
                
                HStack(spacing: 35){
                    Text("휴대폰 번호")
                        .font(.system(size: 13))
                    
                    TextField("",text: $viewModel.user.phoneNum)
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
                    
                    TextField("",text: $viewModel.user.address)
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
                    
                    TextField("",text: $viewModel.user.addressDetail)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 0)
                        .frame(width: 220, height: 40)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                }
                
                Divider()
                    .frame(height:2)
                    .background(.customGray1)
                    .padding(.horizontal, 30)
                
                Button(
                    action: {
                        // 회원가입 완료 통신 후 메인 화면으로 이동
                    },
                    label: {
                        Text("수정")
                            .foregroundColor(.white)
                    }
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.customPink)
                .cornerRadius(10)
                
                Spacer()
                
                HStack{
                    Button(
                        action: {},
                        label: {
                            Text("회원탈퇴")
                                .foregroundColor(.customGray1)
                                .underline()
                        }
                    ).padding(.horizontal, 30)
                    
                    Spacer()
                    
                    
                    
                    Button(
                        action: {},
                        label: {
                            Text("로그아웃")
                                .foregroundColor(.customGray1)
                                .underline()
                        }
                    ).padding(.horizontal, 30)
                    
                    
                }.padding(.vertical, 30)
            }

            
        }
        
    }


#Preview {
    MyInfoEditingView()
}
