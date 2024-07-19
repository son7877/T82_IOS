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
