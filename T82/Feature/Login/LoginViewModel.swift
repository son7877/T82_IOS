import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var loginContent: LoginContent = LoginContent(email: "", password: "")
    @Published var loginSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.login(email: loginContent.email, password: loginContent.password) { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    self?.loginSuccessful = true
                    self?.errorMessage = nil
                } else {
                    self?.loginSuccessful = false
                    self?.errorMessage = "로그인 실패"
                }
            }
        }
    }
    
    func kakaoLogin() {
        AuthService.shared.loginWithKakao(){ [weak self]
            success in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    self?.loginSuccessful = true
                    self?.errorMessage = nil
                } else {
                    self?.loginSuccessful = false
                    self?.errorMessage = "로그인 실패"
                }
            }
        }
    }
    
    func googleLogin(){
        AuthService.shared.loginWithGoogle(){ [weak self]
            success in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    self?.loginSuccessful = true
                    self?.errorMessage = nil
                } else {
                    self?.loginSuccessful = false
                    self?.errorMessage = "로그인 실패"
                }
            }
        }
    }
}
