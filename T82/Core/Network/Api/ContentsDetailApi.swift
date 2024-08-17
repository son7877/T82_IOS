import Foundation
import Alamofire

class ContentDetailService {
    
    static let shared = ContentDetailService()
    private init() {}
    
    // MARK: - 해당 컨텐츠 상세정보 가져오기
    func getContentDetail(eventInfoId: Int, completion: @escaping (ContentsDetail?) -> Void) {
        let url = Config().ServerHost + "/api/v1/contents/\(eventInfoId)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: ContentsDetail.self) { response in
                switch response.result {
                case .success(let contentDetail):
                    completion(contentDetail)
                    
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
    
    // MARK: - 해당 컨텐츠의 예매 가능한 날짜 가져오기
    func getAvailableDates(eventInfoId: Int, completion: @escaping ([EventsByDate]?) -> Void) {
        let url = Config().ServerHost + "/api/v1/contents/\(eventInfoId)/events"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [EventsByDate].self) { response in
                switch response.result {
                case .success(let availableDates):
                    completion(availableDates)
                    
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                        if let data = response.data {
                            do {
                                let decoder = JSONDecoder()
                                let events = try decoder.decode([EventsByDate].self, from: data)
                                print("Decoded Events: \(events)")
                            } catch {
                                print("Decoding Error: \(error)")
                            }
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(nil)
                }
            }
    }
    
    // MARK: - 시간 별 남은 좌석 수 가져오기
    func getRestSeatsByTime(eventId: Int, completion: @escaping ([RestSeats]?) -> Void) {
        let url = Config().ServerHost + "/api/v1/events/\(eventId)/restseats"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [RestSeats].self) { response in
                switch response.result {
                case .success(let restSeats):
                    completion(restSeats)
                    
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                            print(url)
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
}
