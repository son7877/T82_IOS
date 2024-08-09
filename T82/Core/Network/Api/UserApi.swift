import Foundation
import Alamofire

class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    // MARK: - 로그인
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let loginUrl = "\(Config().AuthHost)/api/v1/users/login"
        
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
                        UserDefaults.standard.set(token, forKey: "token")
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
    func signUp(signUpRequest: SignUpContent , completion: @escaping (Bool) -> Void) {
        
        let signUpUrl = "\(Config().AuthHost)/api/v1/users/signup"
        
        AF.request(signUpUrl, method: .post, parameters: signUpRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        completion((200..<300).contains(httpResponse.statusCode))
                    } else {
                        print("No HTTP Response received.")
                        completion(false)
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("Error: \(error.localizedDescription)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(false)
                }
            }
    }
    
    // 유저 정보 불러오기
    func fetchInfo(completion: @escaping (UserInfo?) -> Void) {
        let fetchUrl = "\(Config().AuthHost)/api/v1/users/me"
        print("Fetching user info from: \(fetchUrl)")
        
        AF.request(fetchUrl, method: .get, headers: Config().getHeaders())
            .validate()
            .responseDecodable(of: UserInfo.self) { response in
                switch response.result {
                case .success(let userInfo):
                    print("Fetch success: \(userInfo)")
                    completion(userInfo)
                case .failure(let error):
                    if let httpResponse = response.response {
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("HTTP Error: \(httpResponse.statusCode)")
                            print("Error Message: \(errorMessage)")
                            print("\(error.localizedDescription)")
                        } else {
                            print("HTTP Error: \(httpResponse.statusCode) with no message")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(nil)
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
        let updateUrl = "\(Config().AuthHost)/api/v1/users/me"
        let parameters = [
            "name": name,
            "password": password,
            "passwordCheck": passwordCheck,
            "address": address,
            "addressDetail": addressDetail
        ]
        
        print("Updating user info at: \(updateUrl) with parameters: \(parameters)")
        
        AF.request(updateUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        completion((200..<300).contains(httpResponse.statusCode))
                    } else {
                        print("No HTTP Response received.")
                        completion(false)
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                        if let data = response.data {
                            do {
                                let decoder = JSONDecoder()
                                let events = try decoder.decode([EventsByDate].self, from: data)
                                print("Decoded Events: \(events)")
                            } catch {
                                print("Decoding Error: \(error)")
                            }
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    
    // MARK: - 회원 탈퇴
    func deleteUser(completion: @escaping (Bool) -> Void) {
        let deleteUrl = "\(Config().AuthHost)/api/v1/users/me"
        
        print("Deleting user at: \(deleteUrl)")
        
        AF.request(deleteUrl, method: .delete, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        completion((200..<300).contains(httpResponse.statusCode))
                    } else {
                        print("No HTTP Response received.")
                        completion(false)
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Error: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(false)
                }
            }
    }
    
    // MARK: - 카카오
    func loginWithKakao(completion: @escaping (Bool) -> Void) {
        
        let loginUrl = "\(Config().AuthHost)/api/v1/users/login/kakao"
        
        AF.request(loginUrl, method: .post, headers: Config().getAccessKakao())
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let token = json["token"] as? String {
                        // 토큰 저장
                        UserDefaults.standard.set(token, forKey: "token")
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
    // MARK: - 구글
    func loginWithGoogle(completion: @escaping (Bool) -> Void) {
        
        let loginUrl = "\(Config().AuthHost)/api/v1/users/login/google"
        
        AF.request(loginUrl, method: .post, headers: Config().getAccessGoogle())
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let token = json["token"] as? String {
                        // 토큰 저장
                        UserDefaults.standard.set(token, forKey: "token")
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
}
