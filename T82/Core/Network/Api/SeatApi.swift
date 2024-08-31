import Foundation
import Alamofire

class SelectSeatService {
    
    static let shared = SelectSeatService()
    private init () {}
    
    // MARK: - 예매 가능한 좌석 리스트 가져오기
    func getSelectableSeats(eventId: Int, completion: @escaping ([SelectableSeat]?) -> Void) {
        
        let url = Config().ServerHost + "/api/v1/events/\(eventId)/seats"
        
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
    // MARK: - 좌석 선택 화면 이동 전 대기열 입장
    func enterWaitingQueue(eventId: Int, completion: @escaping (Result<Bool,Error>)-> Void) {
        let url = Config().ServerHost + "/api/v1/events/\(eventId)/queue/entry"
        
        AF.request(url, method: .post, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("enterWaitingQueue Error: \(error.localizedDescription)")
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
    
    // MARK: - 대기열 웹 뷰 띄우기
    func getWaitingQueue(eventId: Int, completion: @escaping (Result<String,Error>)-> Void) {
        let url = Config().ServerHost + "/api/v1/events/\(eventId)/queue/status"
        
        AF.request(url, method: .get, headers: Config().getHeaders())
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success(let html):
                    completion(.success(html))
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
    // MARK: - 대기열 상태 반환
    func getWaitingStatus(eventId: Int, completion: @escaping (Result<WaitingStatusResponse, Error>) -> Void) {
        let url = Config().ServerHost + "/api/v1/events/\(eventId)/queue/status/user"
        
        AF.request(url, method: .get, headers: Config().getHeaders())
            .validate()
            .responseDecodable(of: WaitingStatusResponse.self) { response in
                switch response.result {
                case .success(let queueStatus):
                    completion(.success(queueStatus))
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
    // MARK: - 좌석 선택 후 결제 페이지로 이동할 시 결제 전까지 Pending 테이블에 추가
    func addPendingSeats(seats: [PendingSeat], completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = Config().ServerHost + "/api/v1/seats/choice"
        
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
