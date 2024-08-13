import SwiftUI

struct SignUpView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject private var signUpContentViewModel = SignUpViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var passwordValidationMessage: String = ""
    @State private var passwordCheckValidationMessage: String = ""
    @State private var showAlert: Bool = false
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var body: some View {
        VStack {
            CustomNavigationBar(
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
            
            ScrollView {
                VStack {
                    TextField("이메일", text: $signUpContentViewModel.signUpContent.email)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("비밀번호", text: $signUpContentViewModel.signUpContent.password)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .onChange(of: signUpContentViewModel.signUpContent.password) { newValue in
                            validatePasswords()
                        }
                    
                    if !passwordValidationMessage.isEmpty {
                        Text(passwordValidationMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .padding([.leading, .trailing], 15)
                            .frame(width: 300, alignment: .leading)
                    }
                    
                    SecureField("비밀번호 확인", text: $signUpContentViewModel.signUpContent.passwordCheck)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .onChange(of: signUpContentViewModel.signUpContent.passwordCheck) { newValue in
                            validatePasswords()
                        }
                    
                    if !passwordCheckValidationMessage.isEmpty {
                        Text(passwordCheckValidationMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .padding([.leading, .trailing], 15)
                            .frame(width: 300, alignment: .leading)
                    }
                    
                    TextField("이름", text: $signUpContentViewModel.signUpContent.name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                    
                    DatePicker("생년월일", selection: $signUpContentViewModel.signUpContent.birthDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .environment(\.locale, Locale.init(identifier: "ko_KR"))
                    
                    TextField("휴대폰 번호", text: $signUpContentViewModel.signUpContent.phoneNumber)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                        .onChange(of: signUpContentViewModel.signUpContent.phoneNumber) { newValue in
                            signUpContentViewModel.signUpContent.phoneNumber = newValue.formattedPhoneNumber()
                        }
                    
                    TextField("주소", text: $signUpContentViewModel.signUpContent.address)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                    
                    TextField("상세 주소", text: $signUpContentViewModel.signUpContent.addressDetail)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .frame(width: 300, height: 50)
                        .tint(.customOrange)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                    
                    HStack {
                        Text("프로필 이미지 등록")
                            .font(.system(size: 17))
                            .padding()
                                                
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                            } else {
                                Text("이미지 선택")
                                    .frame(width: 100, height: 100)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(15)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImage: $selectedImage, isPickerPresented: $isImagePickerPresented)
                        }
                    }
                    
                    if signUpContentViewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    if let errorMessage = signUpContentViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
            
            Button(
                action: {
                    if let selectedImage = selectedImage {
                        if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                            signUpContentViewModel.signUp(withImageData: imageData)
                        } else {
                            signUpContentViewModel.errorMessage = "이미지 변환 실패"
                        }
                    } else {
                        // 이미지 선택하지 않았을 때
                        signUpContentViewModel.signUp(withImageData: nil)
                    }
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
        .onReceive(signUpContentViewModel.$isSignUpSuccess) { isSignUpSuccess in
            if isSignUpSuccess {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("회원가입 완료"),
                message: Text("회원가입이 성공적으로 완료되었습니다."),
                dismissButton: .default(Text("확인")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func validatePasswords() {
        passwordValidationMessage = Validation.validatePassword(signUpContentViewModel.signUpContent.password)
        passwordCheckValidationMessage = Validation.validatePasswordCheck(password: signUpContentViewModel.signUpContent.password, passwordCheck: signUpContentViewModel.signUpContent.passwordCheck)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
