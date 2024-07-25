import Foundation
import Alamofire

class Config{
    let AuthHost = "http://192.168.0.18:8000"
    let TicketHost = "http://192.168.0.18:8080"
    let EventHost = "http://192.168.0.18:8081"
    let CouponHost = "http://192.168.0.18:8082"
    let PaymentHost = "http://192.168.0.18:8083"
    let SeatHost = "http://192.168.0.18:8084"
    
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
