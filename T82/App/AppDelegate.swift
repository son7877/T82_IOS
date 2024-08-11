import SwiftUI
import GoogleSignIn
import KakaoSDKAuth
import Firebase
import FirebaseMessaging
import FirebaseFirestore
import FirebaseAuth

// AppDelegate 클래스 정의
class AppDelegate: NSObject, UIApplicationDelegate {
    
    private var googleSignInConfig: GIDConfiguration?

    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 실행될 때 호출되는 메서드
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Google Sign-In 설정을 위한 클라이언트 ID 설정
        googleSignInConfig = GIDConfiguration(clientID: Config().GIDClientId)
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // iOS 10 이상 버전에서 알림 권한 요청 및 UNUserNotificationCenter 설정
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            // 알림 권한 옵션 설정 (알림, 배지, 사운드)
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            // iOS 10 미만 버전에서 알림 권한 설정
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        // 원격 알림 등록 (APNs)
        application.registerForRemoteNotifications()
        
        // Firebase Cloud Messaging (FCM) 설정
        Messaging.messaging().delegate = self
        
        // 알림 센터의 대리자 설정 (중복 설정 방지)
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // 앱이 URL을 열 때 호출되는 메서드 (Google, Kakao 로그인을 처리)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Google Sign-In 처리
        var handled = GIDSignIn.sharedInstance.handle(url)
        if !handled {
            // KakaoTalk 로그인 처리
            if AuthApi.isKakaoTalkLoginUrl(url) {
                handled = AuthController.handleOpenUrl(url: url)
            }
        }
        return handled
    }

    // Google Sign-In 설정 반환 메서드
    func getGoogleSignInConfig() -> GIDConfiguration? {
        return googleSignInConfig
    }

    // 원격 알림 등록 성공 시 호출되는 메서드
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // APNs 토큰을 FCM에 등록
        Messaging.messaging().apnsToken = deviceToken
    }
}

// Cloud Messaging 설정 및 토큰 처리
extension AppDelegate: MessagingDelegate {
    
    // FCM 토큰이 새로 갱신될 때 호출되는 메서드
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        print("=======FCM token=======")
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        // Firestore에 FCM 토큰 저장 (또는 서버에 전송)
        let db = Firestore.firestore()
        if let userId = Auth.auth().currentUser?.uid {
            print("Current user ID: \(userId)")
            db.collection("users").document(userId).setData(["fcmToken": fcmToken!], merge: true) { error in
                if let error = error {
                    print("Error saving FCM token: \(error.localizedDescription)")
                } else {
                    print("FCM token successfully saved.")
                }
            }
        } else{
            print("User is not signed in.")
        }

        print(dataDict)
    }
}

// 사용자 알림 처리 (In-App Notification)
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
    // 앱이 포그라운드에 있을 때 알림이 수신되면 호출되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo

        // 알림에 포함된 메시지 ID 출력
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)

        // 알림 표시 옵션 설정 (배너, 배지, 사운드)
        completionHandler([[.banner, .badge, .sound]])
    }

    // 사용자가 알림을 클릭했을 때 호출되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        // 알림에 포함된 메시지 ID 출력
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)

        // 완료 핸들러 호출
        completionHandler()
    }
}
