import Combine
import Alamofire
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var signUpContent = SignUpContent()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSignUpSuccess = false
    
    var cancellables = Set<AnyCancellable>()
    
    struct SignUpContent {
        var email = ""
        var password = ""
        var passwordCheck = ""
        var name = ""
        var birthday = Date()
        var phoneNum = ""
        var address = ""
        var addressDetail = ""
    }
    
    func register() {
        isLoading = true
        errorMessage = nil
        
        print("Starting registration...")
        
        AuthService.signUp(
            email: signUpContent.email,
            password: signUpContent.password,
            passwordCheck: signUpContent.passwordCheck,
            name: signUpContent.name,
            birthDate: signUpContent.birthday,
            phoneNumber: signUpContent.phoneNum,
            address: signUpContent.address,
            addressDetail: signUpContent.addressDetail
        )
        .receive(on: DispatchQueue.main) // Ensure we receive the response on the main thread
        .sink { completion in
            print("Received completion: \(completion)")
            self.isLoading = false
            if case .failure(let error) = completion {
                self.errorMessage = error.localizedDescription
                print("Error: \(error.localizedDescription)")
            }
        } receiveValue: { success in
            print("Received success: \(success)")
            self.isSignUpSuccess = success
        }
        .store(in: &cancellables)
    }
}
