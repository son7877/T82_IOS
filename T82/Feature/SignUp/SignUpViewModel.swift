import Combine
import Alamofire
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var signUpContent = SignUpContent(email: "", password: "", passwordCheck: "", name: "", birthDate: Date(), phoneNumber: "", address: "", addressDetail: "")
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccess = false
    
    var cancellables = Set<AnyCancellable>()
    
    func signUp(){
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.signUp(
            signUpRequest: signUpContent
        ) { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    self?.isSignUpSuccess = true
                    self?.errorMessage = nil
                } else {
                    self?.isSignUpSuccess = false
                    self?.errorMessage = "회원가입 실패"
                }
            }
        }
    }
}
