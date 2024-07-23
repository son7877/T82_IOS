import Foundation
import Alamofire

class SelectSeatService {
    
    static let shared = SelectSeatService()
    private init () {}
    
    // MARK: - 예매 가능한 좌석 리스트 가져오기
    func getSelectableSeats(eventId: Int, completion: @escaping ([SelectableSeat]?) -> Void) {
        
        let url = Config().TicketHost + "/api/v1/events/\(eventId)/seats"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [SelectableSeat].self) { response in
                switch response.result {
                case .success(let selectableSeats):
                    completion(selectableSeats)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(nil)
                }
            }
    }
}
