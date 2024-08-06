import Foundation
import Alamofire

class Config{
    let AuthHost = "https://t82.store"
    let CouponHost = "https://t82.store"
    let TicketHost = "https://t82.store"
    let SeatHost = "https://t82.store"
    let EventHost = "https://t82.store"
    let PaymentHost = "https://t82.store"
    let VersionCheckHost = "http://192.168.0.18:8080"
    
    let appId = "6523415914"
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
