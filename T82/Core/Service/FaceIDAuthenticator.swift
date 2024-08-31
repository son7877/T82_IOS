import LocalAuthentication

class FaceIDAuthenticator {
    static let shared = FaceIDAuthenticator()
    
    private init() {}
    
    func authenticateWithFaceID(completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "환불 신청을 위해 Face ID 인증이 필요합니다."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil)
                    } else {
                        let message = authenticationError?.localizedDescription ?? "Face ID 인증에 실패했습니다."
                        completion(false, message)
                    }
                }
            }
        } else {
            let message = error?.localizedDescription ?? "Face ID를 사용할 수 없습니다."
            completion(false, message)
        }
    }
}
