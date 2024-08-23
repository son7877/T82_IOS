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
    
    // 알람 허용 여부 확인
    @Published var notificationPermissionGranted: Bool = false
    
    // 로그인
    private func handleLoginResult(success: Bool) {
        DispatchQueue.main.async {
            self.isLoading = false
            if success {
                self.loginSuccessful = true
                self.errorMessage = nil
                
                // FCM 토큰을 저장하고, 저장 후 postToken을 호출
                self.saveFCMTokenToFirestoreAndPostToken()
            } else {
                self.loginSuccessful = false
                self.errorMessage = "로그인 실패"
            }
        }
    }
    
    private func saveFCMTokenToFirestoreAndPostToken() {
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

                    self.notificationPermissionGranted = true

                    if let userId = Auth.auth().currentUser?.uid {
                        let db = Firestore.firestore()
                        db.collection("users").document(userId).setData(["fcmToken": token], merge: true) { error in
                            if let error = error {
                                print("Error saving FCM token: \(error.localizedDescription)")
                            } else {
                                print("Login: FCM token successfully saved.")
                                // FCM 토큰이 저장된 후 postToken을 호출
                                self.postToken()
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
            
            let userID = self?.loginContent.email
            UserDefaults.standard.set(userID, forKey: "userID")
            self?.handleLoginResult(success: success)
            UserDefaults.standard.set(false, forKey: "isSocialLogin")
        }
    }
    
    func kakaoLogin() {
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.loginWithKakao { [weak self] success in
            SocialLogin.shared.getKakaoEmail { kakaoEmail in
                if let email = kakaoEmail {
                    UserDefaults.standard.set(email, forKey: "userID")
                    // UserDefaults에 소셜 로그인 여부 저장
                    UserDefaults.standard.set(true, forKey: "isSocialLogin")
                }
            }
            self?.handleLoginResult(success: success)
        }
    }
    
    func googleLogin() {
        self.isLoading = true
        self.errorMessage = nil
        
        AuthService.shared.loginWithGoogle { [weak self] success in
            if let email = SocialLogin.shared.getGoogleEmail() {
                UserDefaults.standard.set(email, forKey: "userID")
                UserDefaults.standard.set(true, forKey: "isSocialLogin")
            }
            self?.handleLoginResult(success: success)
        }
    }
    
    private func postToken(){
        AuthService.shared.registerFCMToken { result in
            switch result {
            case .success:
                print("FCM 토큰 등록 성공")
            case .failure(let error):
                print("FCM 토큰 등록 실패: \(error.localizedDescription)")
            }
        }
    }
}
