import Foundation
import Alamofire

class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    // MARK: - 로그인
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let loginUrl = "\(Config().AuthHost)/api/v1/user/login"
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request(loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let token = json["token"] as? String {
                        // 토큰 저장
                        UserDefaults.standard.set(token, forKey: "userToken")
                        // 토큰 저장 확인
                        print("User token: \(token)")
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure:
                    completion(false)
                }
            }
    }
    
    // MARK: - 회원 가입
    func signUp(
        email: String,
        password: String,
        passwordCheck: String,
        name: String,
        birthDate: Date,
        phoneNumber: String,
        address: String,
        addressDetail: String,
        completion: @escaping (Bool) -> Void
    ) {
        
        let signUpUrl = "\(Config().AuthHost)/api/v1/user/signup"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let parameters = [
            "email": email,
            "password": password,
            "passwordCheck": passwordCheck,
            "name": name,
            "birthDate": dateFormatter.string(from: birthDate),
            "phoneNumber": phoneNumber,
            "address": address,
            "addressDetail": addressDetail
        ]
        
        AF.request(signUpUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .response { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
    }
    
    // MARK: - 회원정보 수정
    func updateUserInfo(
        name: String,
        password: String,
        passwordCheck: String,
        address: String,
        addressDetail: String,
        completion: @escaping (Bool) -> Void
    ) {
        
        let updateUrl = "\(Config().AuthHost)/api/v1/user/me"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let parameters = [
            "name": name,
            "password": password,
            "passwordCheck": passwordCheck,
            "address": address,
            "addressDetail": addressDetail
        ]
        
        AF.request(updateUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .response { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
    }
    
    // MARK: - 회원 탈퇴
    func deleteUser(completion: @escaping (Bool) -> Void) {
        
        let deleteUrl = "\(Config().AuthHost)/api/v1/user/me"
        
        AF.request(deleteUrl, method: .delete)
            .validate()
            .response { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
    }
}
