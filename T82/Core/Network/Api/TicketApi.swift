import Foundation
import Alamofire

class TicketService {
    static let shared = TicketService()
    private init() {}
    
    // MARK: - 내 티켓 정보 반환 (페이징)
    func getMyTickets(page: Int, size: Int, completion: @escaping (Result<MyTicketResponse, Error>) -> Void) {
        
        let urlString = Config().TicketHost + "/api/v1/tickets"
        let parameters: Parameters = ["page": page, "size": size]
        
        AF.request(urlString, method: .get, parameters: parameters, headers: Config().getHeaders()).responseDecodable(of: MyTicketResponse.self) { response in
            switch response.result {
            case .success(let myticketResponse):
                completion(.success(myticketResponse))
            case .failure(let error):
                if let httpResponse = response.response {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Error Message: \(errorMessage)")
                        print("Error: \(error.localizedDescription)")
                    }
                } else {
                    print("Network Error: \(error.localizedDescription)")
                }
                completion(.failure(error))
            }
        }
    }

}
