import SwiftUI

struct LoginView: View {
    
    @FocusState private var isFocused: Bool
    @State private var loginContent: LoginContent = LoginContent(email: "", password: "")
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding()
                
                // MARK: 로그인 입력 필드
                TextField("이메일", text: $loginContent.email)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                
                SecureField("비밀번호", text: $loginContent.password)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .frame(width: 300, height: 50)
                    .tint(.customOrange)
                    .focused($isFocused)
                
                HStack {
                    LoginButton()
                    
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
                    Button(action: {}, label: {
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
            }
            .padding()
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

// MARK: - 로그인 버튼
private struct LoginButton: View{
    var body: some View{
        Button(
            action: {
                // 로그인 통신 후 메인 뷰로 이동
            },
            label: {
                Text("로그인")
            }
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.customOrange)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}
// MARK: - 회원가입 버튼
private struct SignUpButton: View {
    var body: some View {
        NavigationLink(
            destination: SignUpView(),
            label: {
                Text("회원가입")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.customOrange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
