import Foundation
import Alamofire

class Config{
    let ServerHost: String
    let VersionCheckHost: String
    
    let appId: String
    let kakaoAppKey: String
    let GIDClientId: String
    
    init() {
        self.ServerHost = ProcessInfo.processInfo.environment["SERVER_HOST"] ?? "https://t82.store"
        self.VersionCheckHost = ProcessInfo.processInfo.environment["VERSION_CHECK_HOST"] ?? "http://34.132.100.39:8080"
        
        self.appId = ProcessInfo.processInfo.environment["APP_ID"] ?? "6523415914"
        self.kakaoAppKey = ProcessInfo.processInfo.environment["KAKAO_APP_KEY"] ?? "7482ff10ddcc2f9b977ca52de9dd4052"
        self.GIDClientId = ProcessInfo.processInfo.environment["GID_CLIENT_ID"] ?? "366365938384-9mkgktkneksv2rivdqpprt2p9pb20eom.apps.googleusercontent.com"
    }
    
    var token: String?{
        return UserDefaults.standard.string(forKey: "token")
    }
    
    func getHeaders() -> HTTPHeaders {
        return [
            "Authorization": "Bearer \(token ?? "")",
            "Accept": "application/json"
        ]
    }
    
    func getImageHeaders() -> HTTPHeaders {
        return [
            "Accept": "multipart/form-data"
        ]
    }
    
    var accessTokenKaKao: String? {
        return UserDefaults.standard.string(forKey: "KakaoToken")
    }
    
    var accessTokenGoogle: String? {
        return UserDefaults.standard.string(forKey: "GoogleToken")
    }
    
    func getAccessKakao() -> HTTPHeaders {
        return [
            "Authorization": "\(accessTokenKaKao ?? "")",
            "Accept": "application/json"
        ]
    }
    
    func getAccessGoogle() -> HTTPHeaders {
        return [
            "Authorization": "\(accessTokenGoogle ?? "")",
            "Accept": "application/json"
        ]
    }
}
