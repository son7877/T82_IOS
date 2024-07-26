import Alamofire
import Foundation


class MainContentsService{
    
    static let shared = MainContentsService()
    private init() {}
    
    // MARK: - GET
    
    // 현재 판매 중인 티켓 중 판매량 많은 순
    func getMainEventsRank(completion: @escaping ([MainContents]?) -> Void) {
        
        let mainEventUrl = "\(Config().EventHost)/api/v1/contents/rank"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        if let mainContents = response.value {
                            completion(mainContents)
                            print(
                                """
                                Success response data: \(mainContents)
                                """
                            )
                        }
                    } else {
                        completion(nil)
                        print("error")
                    }
                } else {
                    completion(nil)
                    print("error")
                }
            }
    }
    
    // 상위 카테고리 별 판매량 많은 순
    func getMainEventsCategoryRank(category: Int, completion: @escaping ([MainContents]?) -> Void) {
        
        let mainEventUrl = "\(Config().EventHost)/api/v1/contents/genre/\(category)/rank"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        if let mainContents = response.value {
                            completion(mainContents)
                            print(
                                """
                                Success response data: \(mainContents)
                                """
                            )
                        }
                    } else {
                        completion(nil)
                        print("error")
                    }
                } else {
                    completion(nil)
                    print("error")
                }
            }
    }

    // 전체 공연 중 티켓 오픈이 다가오는 순
    func getMainEventsOpenSoon(completion: @escaping ([MainContents]?) -> Void) {
        
        let mainEventUrl = "\(Config().EventHost)/api/v1/contents"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        if let mainContents = response.value {
                            completion(mainContents)
                            print(
                                """
                                Success response data: \(mainContents)
                                """
                            )
                        }
                    } else {
                        completion(nil)
                        print("error")
                    }
                } else {
                    completion(nil)
                    print("error")
                }
            }
    }

}

class ContentDetailService {
    
    static let shared = ContentDetailService()
    private init() {}
    
    // MARK: - 해당 컨텐츠 상세정보 가져오기
    func getContentDetail(eventInfoId: Int, completion: @escaping (ContentsDetail?) -> Void) {
        let url = Config().EventHost + "/api/v1/contents/\(eventInfoId)"
        
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
        let url = Config().EventHost + "/api/v1/contents/\(eventInfoId)/events"
        
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
        let url = Config().SeatHost + "/api/v1/events/\(eventId)/restseats"
        
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
                    completion(nil)
                }
            }
    }
    
}
