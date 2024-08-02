import SwiftUI
import GoogleSignInSwift
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject private var loginContentViewMoel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding()
                
                // MARK: - 로그인 입력 필드
                TextField("이메일", text: $loginContentViewMoel.loginContent.email)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                SecureField("비밀번호", text: $loginContentViewMoel.loginContent.password)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                
                // MARK: - 로그인 & 회원가입 버튼
                HStack {
                    LoginButton(viewModel: loginContentViewMoel)
                    
                    SignUpButton()
                }
                
                Divider()
                    .padding(.bottom, 3)
                    .padding(.top, 20)
                    .padding(.horizontal, 50)
                
                Button(
                    action: {
                        // 비밀번호 찾기 로직 추후 추가
                    },
                    label: {
                        Text("비밀번호를 잊으셨습니까?")
                            .foregroundColor(Color.customGray1)
                            .font(.system(size: 15))
                    }
                )
                // MARK: - 소셜 로그인
                // MARK: - 카카오
                HStack {
                    Button(action: {
                        if (UserApi.isKakaoTalkLoginAvailable()) {
                            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                if let error = error {
                                    print("1==================== \(error)")
                                }
                                if let oauthToken = oauthToken{
                                    
                                }
                            }
                        } else {
                            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                if let error = error {
                                    print("2===================== \(error)")
                                }
                                if let oauthToken = oauthToken{
                                    print("kakao success")
                                }
                            }
                        }
                    }, label: {
                        Image("kakao")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    })
                    
                    // MARK: - 구글
                    Button(action: {
                        
                    }, label: {
                        Image("google")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    })
                }
                .padding()
                
            }
            .padding()
            .onTapGesture {
                isFocused = false
            }
            .navigationBarBackButtonHidden()
            .alert(isPresented: .constant(loginContentViewMoel.errorMessage != nil)) {
                Alert(title: Text("로그인 실패"), message: Text(loginContentViewMoel.errorMessage ?? ""), dismissButton: .default(Text("확인")))
            }
            .navigationDestination(isPresented: $loginContentViewMoel.loginSuccessful) {
                MainView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
