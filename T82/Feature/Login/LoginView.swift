import SwiftUI

struct LoginView: View {
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        VStack {
            Image("Logo")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding()
            TextField("Email", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding()
                .frame(width: 300, height: 50)
                .tint(.customOrange)
            TextField("Password", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding()
                .frame(width: 300, height: 50)
                .tint(.customOrange)
            
            HStack{
                Button(
                    action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, 
                    label: {
                        Text("로그인")
                    }
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.customOrange)
                .foregroundColor(.white)
                .cornerRadius(20)
                
                Button(
                    action: {
                        // SignUpView()로 이동
                        
                    }, label: {
                        Text("회원가입")
                    }
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.customOrange)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
            
            Divider()
                .padding(.bottom, 3)
                .padding(.top, 20)
                .padding(.horizontal, 50)
            
            Button(
                action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                label: {
                    Text("비밀번호를 잊으셨습니까?")
                        .foregroundColor(.customgray1)
                        .font(.system(size: 15))
                }
            )
            
            HStack{
                Button(
                    action: {},
                    label: {
                        Image("naver")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
               )
               
                Button(
                    action: {},
                    label: {
                        Image("kakao")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                )
                
                Button(
                    action: {},
                    label: {
                        Image("google")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                )
                
            }
            .padding()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
