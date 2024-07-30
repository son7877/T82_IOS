import Foundation
import Alamofire

class SelectSeatService {
    
    static let shared = SelectSeatService()
    private init () {}
    
    // MARK: - 예매 가능한 좌석 리스트 가져오기
    func getSelectableSeats(eventId: Int, completion: @escaping ([SelectableSeat]?) -> Void) {
        
        let url = Config().SeatHost + "/api/v1/events/\(eventId)/seats"
        
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
    
    // MARK: - 좌석 선택 후 결제 페이지로 이동할 시 결제 전까지 Pending 테이블에 추가
    func addPendingSeats(seats: [PendingSeat], completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Config().SeatHost + "/api/v1/seats/choice"
        
        AF.request(url, method: .put, parameters: seats, encoder: JSONParameterEncoder.default, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("Pending seats Error: \(error.localizedDescription)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(.failure(error))
                }
            }
    }
}
