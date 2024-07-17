import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginContent: LoginContent
    
    init(
        loginContent: LoginContent = LoginContent(
            email: "",
            password: "")) {
        self.loginContent = loginContent
    }
}
