import SwiftUI

struct MyInfoEditingView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject private var viewModel = MyInfoEditingViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var passwordValidationMessage: String = ""
    @State private var passwordCheckValidationMessage: String = ""
    @State private var showDeleteConfirmation = false
    @State private var navigateToLogin = false
    @State private var showEditSuccessAlert = false
        
    var body: some View {
        VStack {
            Divider()
                .frame(height: 2)
                .background(Color.gray)
                .padding(.horizontal, 30)

            HStack(spacing: 30) {
                Text("이름(닉네임)")
                    .font(.system(size: 13))
                
                TextField("", text: $viewModel.user.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 60) {
                Text("이메일")
                    .font(.system(size: 13))
                
                TextField("", text: $viewModel.user.email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
            }
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50) {
                Text("생년월일")
                    .font(.system(size: 13))
                
                DatePicker("", selection: $viewModel.user.birthDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50) {
                Text("비밀번호")
                    .font(.system(size: 13))
                
                SecureField("새로 설정할 비밀번호", text: $viewModel.user.password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .onChange(of: viewModel.user.password) { newValue in
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
            
            HStack(spacing: 25) {
                Text("비밀번호 확인")
                    .font(.system(size: 13))
                
                SecureField("", text: $viewModel.user.passwordCheck)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .onChange(of: viewModel.user.passwordCheck) { newValue in
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
            
            HStack(spacing: 35) {
                Text("휴대폰 번호")
                    .font(.system(size: 13))
                
                TextField("", text: $viewModel.user.phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 70) {
                Text("주소")
                    .font(.system(size: 13))
                
                TextField("", text: $viewModel.user.address)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            
            Divider()
                .padding(.horizontal, 30)
            
            HStack(spacing: 50) {
                Text("상세주소")
                    .font(.system(size: 13))
                
                TextField("", text: $viewModel.user.addressDetail)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 0)
                    .frame(width: 220, height: 40)
                    .tint(Color.orange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
            }
            
            Divider()
                .frame(height: 2)
                .background(Color.gray)
                .padding(.horizontal, 30)
            
            Button(
                action: {
                    viewModel.editUserInfo()
                },
                label: {
                    Text("수정")
                        .foregroundColor(.white)
                }
            )
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.pink)
            .cornerRadius(10)
            
            Spacer()
            
            HStack {
                Button(
                    action: {
                        showDeleteConfirmation = true
                    },
                    label: {
                        Text("회원탈퇴")
                            .foregroundColor(Color.gray)
                            .underline()
                    }
                )
                .padding(.horizontal, 30)
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("회원 탈퇴"),
                        message: Text("정말로 탈퇴하시겠습니까?"),
                        primaryButton: .destructive(Text("탈퇴")) {
                            viewModel.deleteUser()
                        },
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
                
                Spacer()
                
                Button(
                    action: {
                        navigateToLogin = true
                    },
                    label: {
                        Text("로그아웃")
                            .foregroundColor(Color.gray)
                            .underline()
                    }
                )
                .padding(.horizontal, 30)
            }
            .padding(.vertical, 30)
        }
        .onAppear {
            viewModel.fetchUserInfo()
        }
        .onChange(of: viewModel.isEditSuccess) { isEditSuccess in
            if isEditSuccess {
                showEditSuccessAlert = true
            }
        }
        .onChange(of: viewModel.isDeleteSuccess) { isDeleteSuccess in
            if isDeleteSuccess {
                navigateToLogin = true
            }
        }
        .background(
            NavigationLink(
                destination: LoginView(),
                isActive: $navigateToLogin,
                label: { EmptyView() }
            )
        )
        .alert(isPresented: $showEditSuccessAlert) {
            Alert(
                title: Text("수정 완료"),
                message: Text("회원 정보가 성공적으로 수정되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

#Preview {
    MyInfoEditingView()
}
