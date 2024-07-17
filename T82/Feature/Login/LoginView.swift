import SwiftUI

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
                
                // MARK: 로그인 입력 필드
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
                
                Divider()
                    .padding(.bottom, 3)
                    .padding(.top, 20)
                    .padding(.horizontal, 50)
                
                Button(
                    action: {
                        // 비밀번호 찾기 액션
                    },
                    label: {
                        Text("비밀번호를 잊으셨습니까?")
                            .foregroundColor(Color.customGray1)
                            .font(.system(size: 15))
                    }
                )
                // MARK: - 소셜 로그인
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image("naver")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    })
                    
                    Button(action: {}, label: {
                        Image("kakao")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    })
                    
                    Button(action: {}, label: {
                        Image("google")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    })
                }
                .padding()
                
                Button(
                    action: {
                        let urlString = "https://pay.toss.im/payfront/auth?payToken=77w2INp17zKTmGLdNk4r97"

                        
                        if let url = URL(string: urlString) {
                            
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                print("오류")
                            }
                        }
                    },
                    label: {
                        Text("토스 연결 테스트")
                            .foregroundColor(Color.customGray1)
                            .font(.system(size: 15))
                    }
                )
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
                MainpageView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
