import KakaoSDKUser
import GoogleSignIn

class SocialLogin {
    static let shared = SocialLogin()
    
    func getKakaoEmail(completion: @escaping (String?) -> Void) {
        UserApi.shared.me { user, error in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
            } else {
                let email = user?.kakaoAccount?.email
                completion(email)
            }
        }
    }
    
    func getGoogleEmail() -> String? {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else {
            return nil
        }
        return currentUser.profile?.email
    }
}
