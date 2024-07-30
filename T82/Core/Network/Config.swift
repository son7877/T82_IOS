import Foundation
import Alamofire

class Config{
    let AuthHost = "http://34.69.17.27"
    
    let CouponHost = "https://t82.store"
    let TicketHost = "https://t82.store"
    
    let SeatHost = "https://t82.store"
    let EventHost = "https://t82.store"
    
    let PaymentHost = "https://t82.store"
    
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
