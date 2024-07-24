import Foundation
import Alamofire

class Config{
    let AuthHost = "http://192.168.68.103:8000"
    let TicketHost = "http://192.168.68.103:8080"
    let EventHost = "http://192.168.68.103:8081"
    let CouponHost = "http://192.168.68.103:8082"
    
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
