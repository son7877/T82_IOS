import SwiftUI
import GoogleSignIn
import KakaoSDKAuth
import Firebase
import FirebaseMessaging
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private var googleSignInConfig: GIDConfiguration?
    let gcmMessageIDKey = "gcm.message_id"
    
    // 어플 실행 시
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        googleSignInConfig = GIDConfiguration(clientID: Config().GIDClientId)
        
        FirebaseApp.configure()
        
//        requestNotificationAuthorization()

        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled = GIDSignIn.sharedInstance.handle(url)
        if !handled {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                handled = AuthController.handleOpenUrl(url: url)
            }
        }
        return handled
    }
    
    func getGoogleSignInConfig() -> GIDConfiguration? {
        return googleSignInConfig
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // 푸시 알림 권한 요청
    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            // 권한 허용 여부 확인
            if granted {
                print("Notification permission granted.")
                
                // 익명 인증 후 FCM 토큰 저장
                self.authenticateUserAnonymously { success in
                    if success {
                        self.registerFCMToken()
                    } else {
                        print("Anonymous authentication failed.")
                    }
                }
            } else {
                print("Notification permission denied.")
                if let error = error {
                    print("Notification authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // 익명 인증
    private func authenticateUserAnonymously(completion: @escaping (Bool) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Error signing in anonymously: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let user = authResult?.user {
                print("Successfully signed in anonymously. User ID: \(user.uid)")
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    // FCM 토큰 등록 및 Firestore 저장
    private func registerFCMToken() {
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
    }
}

// Cloud Messaging 설정 및 토큰 처리
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("=======FCM token=======")
        registerFCMToken()
    }
}

// 사용자 알림 처리 (In-App Notification)
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)
        completionHandler([[.banner, .badge, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        completionHandler()
    }
}
