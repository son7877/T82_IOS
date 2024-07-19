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
        
        AuthService.login(email: loginContent.email, password: loginContent.password)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    self.loginSuccessful = true
                    print("Login successful")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Login failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                print("Received response: \(response)")
            })
            .store(in: &cancellables)
    }
}
