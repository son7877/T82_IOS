import Foundation
import Alamofire

class Config{
    let AuthHost = "https://t82.store"
    let CouponHost = "https://t82.store"
    let TicketHost = "https://t82.store"
    let SeatHost = "https://t82.store"
    let EventHost = "https://t82.store"
    let PaymentHost = "https://t82.store"
    let VersionCheckHost = "http://34.132.100.39:8080"
    
    let appId = "6523415914"
    let kakaoAppKey = "7482ff10ddcc2f9b977ca52de9dd4052"
    let GIDClientId = "366365938384-9mkgktkneksv2rivdqpprt2p9pb20eom.apps.googleusercontent.com"
    
    var token: String?{
        return UserDefaults.standard.string(forKey: "token")
    }
    
    func getHeaders() -> HTTPHeaders {
        return [
            "Authorization": "Bearer \(token ?? "")",
            "Accept": "application/json"
        ]
    }
}
