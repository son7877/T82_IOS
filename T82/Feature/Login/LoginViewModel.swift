import Foundation
import FirebaseAuth
import FirebaseMessaging
import FirebaseFirestore
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var loginContent: LoginContent = LoginContent(email: "", password: "")
    @Published var loginSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private func handleLoginResult(success: Bool) {
        DispatchQueue.main.async {
            self.isLoading = false
            if success {
                self.loginSuccessful = true
                self.errorMessage = nil
                
                // 추가 작업: 로그인 성공 후 FCM 토큰 저장 또는 푸시 알림 권한 요청
                self.saveFCMTokenToFirestore()
                
            } else {
                self.loginSuccessful = false
                self.errorMessage = "로그인 실패"
            }
        }
    }

    private func saveFCMTokenToFirestore() {
        // 푸시 알림 권한 요청
        requestNotificationAuthorization { granted in
            if granted {
                Messaging.messaging().token { token, error in
                    if let error = error {
                        print("Error fetching FCM token: \(error.localizedDescription)")
                        return
                    }

                    guard let token = token else {
                        print("FCM token is nil.")
                        return
                    }

                    print("FCM token: \(token)")

                    if let userId = Auth.auth().currentUser?.uid {
                        let db = Firestore.firestore()
                        db.collection("users").document(userId).setData(["fcmToken": token], merge: true) { error in
                            if let error = error {
                                print("Error saving FCM token: \(error.localizedDescription)")
                            } else {
                                print("FCM token successfully saved.")
                            }
                        }
                    } else {
                        print("User is not authenticated.")
                    }
                }
            } else {
                print("Notification permission not granted.")
            }
        }
    }

    private func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            }
            completion(granted)
        }
    }

    
    func login() {
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.login(email: loginContent.email, password: loginContent.password) { [weak self] success in
            self?.handleLoginResult(success: success)
        }
    }
    
    func kakaoLogin() {
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.loginWithKakao { [weak self] success in
            self?.handleLoginResult(success: success)
        }
    }
    
    func googleLogin() {
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.loginWithGoogle { [weak self] success in
            self?.handleLoginResult(success: success)
        }
    }
}
