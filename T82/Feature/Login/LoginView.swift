import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

struct LoginView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject private var loginContentViewMoel = LoginViewModel()
    @StateObject private var versionCheckViewModel = VersionCheckViewModel()
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding()
                
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
                
                HStack {
                    LoginButton(viewModel: loginContentViewMoel)
                    
                    SignUpButton()
                }
                
                // 로그인 실패 시 문구 출력
                if let errorMessage = loginContentViewMoel.errorMessage {
                    Text("로그인에 실패하였습니다. 다시 시도해 주세요")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                Divider()
                    .padding(.bottom, 3)
                    .padding(.top, 20)
                    .padding(.horizontal, 50)
                
                HStack {
                    Button(action: {
                        loginWithKakao()
                    }, label: {
                        Image("kakao")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    })
                    
                    Button(action: {
                        loginWithGoogle()
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
            
            // 버전 업데이트 알림
            .alert(isPresented: Binding<Bool>(
                get: { versionCheckViewModel.shouldShowUpdateAlert != nil },
                set: { _ in versionCheckViewModel.shouldShowUpdateAlert = nil }
            )) {
                Alert(
                    title: Text("업데이트 확인"),
                    message: Text("새로운 버전이 있습니다. 업데이트 하시겠습니까?"),
                    primaryButton: .default(Text("업데이트"), action: {
                        openTestFlight()
                    }),
                    secondaryButton: .cancel(Text("나중에"))
                )
            }
            .navigationDestination(isPresented: $loginContentViewMoel.loginSuccessful) {
                MainView(selectedIndex: 4)
            }
            .onAppear {
                versionCheckViewModel.checkForUpdate()
            }
        }
    }
    
    private func loginWithKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                handleKakaoLogin(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                handleKakaoLogin(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    private func handleKakaoLogin(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            print("카카오 로그인 오류: \(error)")
        } else if let token = oauthToken {
            // 서버로 보낼 access 토큰 저장
            UserDefaults.standard.set(token.accessToken, forKey: "KakaoToken")
            print("카카오 액세스 토큰: \(token.accessToken)")
            DispatchQueue.main.async {
                // 서버에 access 토큰 전송 후 토큰 재발급 후 UserDefaults에 저장
                loginContentViewMoel.kakaoLogin()
            }
        }
    }
    
    private func loginWithGoogle() {
        guard let presentingViewController = getRootViewController() else {
            return
        }
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                print("Google 로그인 오류: \(error.localizedDescription)")
            } else if let signInResult = signInResult {
                let user = signInResult.user
                let accessToken = user.accessToken
                // 서버로 보낼 access 토큰 저장
                UserDefaults.standard.set(accessToken.tokenString, forKey: "GoogleToken")
                print("Google Access Token: \(accessToken.tokenString)")
                DispatchQueue.main.async {
                    // 서버에 access 토큰 전송 후 토큰 재발급 후 UserDefaults에 저장
                    loginContentViewMoel.googleLogin()
                }
            }
        }
    }
    
    private func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return nil
        }
        return rootViewController
    }
    
    private func openTestFlight() {
        if let url = URL(string: "itms-beta://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                if let appStoreUrl = URL(string: "https://apps.apple.com/app/testflight/id899247664") {
                    UIApplication.shared.open(appStoreUrl)
                }
            }
        }
    }
    
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
