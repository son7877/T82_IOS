import Foundation
import Alamofire

class Config{
    let AuthHost = "http://192.168.63.63:8000"
    let TicketHost = "http://192.168.63.63:8080"
    let EventHost = "http://192.168.63.63:8081"
    
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
