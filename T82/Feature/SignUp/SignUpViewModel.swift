import Combine
import Alamofire
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var signUpContent = SignUpContent(email: "", password: "", passwordCheck: "", name: "", birthday: Date(), phoneNumber: "", address: "", addressDetail: "")
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccess = false
    
    var cancellables = Set<AnyCancellable>()
    
    func signUp(){
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.signUp(
            email: signUpContent.email,
            password: signUpContent.password,
            passwordCheck: signUpContent.passwordCheck,
            name: signUpContent.name,
            birthDate: signUpContent.birthday,
            phoneNumber: signUpContent.phoneNumber,
            address: signUpContent.address,
            addressDetail: signUpContent.addressDetail
        ) {
            [weak self] success in
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
