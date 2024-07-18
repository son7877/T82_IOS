import Foundation
import Alamofire
import Combine

class AuthService {
    
    // MARK: - 로그인
    static func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> { //**
        
        let loginUrl = "\(Config().AuthHost)/api/v1/user/login"
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        return Future { promise in
            AF.request(loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
    
    // MARK: - 회원 가입
    static func signUp(
        email: String,
        password: String,
        passwordCheck: String,
        name: String,
        birthDate: Date,
        phoneNumber: String,
        address: String,
        addressDetail: String
    ) -> AnyPublisher<Bool, Error> {
        
        let url = "\(Config().AuthHost)/api/v1/user/signup"
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "passwordCheck": passwordCheck,
            "name": name,
            "birthDate": ISO8601DateFormatter().string(from: birthDate), // BirthDate formatting to ISO8601
            "phoneNumber": phoneNumber,
            "address": address,
            "addressDetail": addressDetail
        ]
        
        print("Sign Up URL: \(url)")
        print("Parameters: \(parameters)")
        
        return Future { promise in
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .response { response in
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                    } else {
                        print("No HTTP response")
                    }
                    
                    if let error = response.error {
                        print("Request error: \(error)")
                    }
                    
                    if let data = response.data {
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                    }
                    
                    if let httpResponse = response.response {
                        if (200..<300).contains(httpResponse.statusCode) {
                            if let data = response.data {
                                if let jsonString = String(data: data, encoding: .utf8) {
                                    print("Success response JSON: \(jsonString)")
                                    if jsonString == "회원가입 성공" {
                                        promise(.success(true))
                                        return
                                    }
                                }
                                do {
                                    let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                                    print("Success response data: \(signUpResponse)")
                                    promise(.success(signUpResponse.success))
                                } catch {
                                    let errorMessage = "회원가입에 실패했습니다 정보를 확인해주세요"
                                    print(errorMessage)
                                    promise(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                                }
                            }
                        } else {
                            if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                                print("Failure response data: \(errorResponse)")
                            }
                            let error = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "상태 코드: \(httpResponse.statusCode)로 요청 실패입니다"])
                            promise(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: NSURLErrorDomain, code: URLError.unknown.rawValue, userInfo: [NSLocalizedDescriptionKey: "서버로부터 응답이 없습니다."])
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
