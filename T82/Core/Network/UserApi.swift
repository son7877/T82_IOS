import Foundation
import Alamofire
import Combine

class AuthService {
    
    // 로그인
    static func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> { //**
        
        let url = "\(Config().AuthHost)/api/v1/user/login"
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        return Future { promise in
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { response in
                    if let httpResponse = response.response {
                        if (200..<300).contains(httpResponse.statusCode) {
                            if let data = response.data {
                                print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                                do {
                                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                                    UserDefaults.standard.set(loginResponse.token, forKey: "token")
                                    print("Success response data: \(loginResponse)")
                                    promise(.success(loginResponse))
                                } catch {
                                    let errorMessage = "로그인에 실패했습니다 이메일과 비밀번호를 확인해주세요"
                                    print(errorMessage)
                                    promise(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                                }
                            }
                        } else {
                            // 응답이 성공 범위 밖에 있는 경우
                            if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                                print("Error response data: \(errorResponse)")
                            }
                            let error = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "이메일과 비밀번호를 확인해주세요"])
                            promise(.failure(error))
                        }
                    } else {
                        // 서버 응답이 없는 경우
                        let error = NSError(domain: NSURLErrorDomain, code: URLError.unknown.rawValue, userInfo: [NSLocalizedDescriptionKey: "서버로부터 응답이 없습니다."])
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
