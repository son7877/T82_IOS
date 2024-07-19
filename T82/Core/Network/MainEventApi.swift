import Alamofire
import Foundation


class MainEventService{
    
    static let shared = MainEventService()
    private init() {}
    
    // MARK: - GET
    
    func getMainEventsRank(completion: @escaping ([MainEvents]?) -> Void) {
        
        let mainEventUrl = "\(Config().EventHost)/api/v1/contents/rank"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainEvents].self) { response in
                if let httpResponse = response.response {
                    if (200..<300).contains(httpResponse.statusCode) {
                        if let mainEvents = response.value {
                            completion(mainEvents)
                            print(
                                """
                                Success response data: \(mainEvents)
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
