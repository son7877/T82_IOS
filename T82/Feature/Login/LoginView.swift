import SwiftUI

struct LoginView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject private var loginContentViewMoel = LoginViewModel()
    
    var body: some View {

        NavigationView {
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
        .navigationBarBackButtonHidden()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
