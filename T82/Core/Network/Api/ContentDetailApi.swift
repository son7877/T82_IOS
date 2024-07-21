import Foundation
import Alamofire

class ContentDetailService {
    
    static let shared = ContentDetailService()
    private init() {}
    
    // MARK: - GET
    
    // 해당 컨텐츠 상세정보 가져오기
    func getContentDetail(eventId: Int, completion: @escaping (ContentsDetail?) -> Void) {
        let url = Config().EventHost + "/api/v1/contents/\(eventId)"
        
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
}
