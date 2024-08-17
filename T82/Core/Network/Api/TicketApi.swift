import Foundation
import Alamofire

class TicketService {
    static let shared = TicketService()
    private init() {}
    
    // MARK: - 내 티켓 정보 반환
    func getMyTickets(completion: @escaping (Result<[MyTicket], Error>) -> Void) {
        
        let urlString = Config().ServerHost + "/api/v1/tickets"
        
        AF.request(urlString, method: .get, headers: Config().getHeaders()).responseDecodable(of: [MyTicket].self) { response in
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
