import Combine
import Alamofire
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var signUpContent = SignUpContent(email: "", password: "", passwordCheck: "", name: "", birthDate: Date(), phoneNumber: "", address: "", addressDetail: "", imageUrl: nil)
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccess = false
    
    var cancellables = Set<AnyCancellable>()
    
    func signUp(withImageData imageData: Data?) {
        self.isLoading = true
        self.errorMessage = nil
        
        if let imageData = imageData {
            AuthService.shared.uploadImage(image: imageData) { [weak self] imageUrl in
                guard let self = self else { return }
                if let imageUrl = imageUrl {
                    self.signUpContent.imageUrl = imageUrl
                }
                self.performSignUp()
            }
        } else {
            self.performSignUp()
        }
    }
    
    private func performSignUp() {
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
