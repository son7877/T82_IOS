import Alamofire
import Foundation

// MARK: - 메인 컨텐츠
class MainContentsService {
    
    static let shared = MainContentsService()
    private init() {}
    
    // MARK: - 현재 판매 중인 티켓 중 판매량 많은 순
    func getMainEventsRank(completion: @escaping ([MainContents]?) -> Void) {
        
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/rank"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                switch response.result{
                case .success(let mainContents):
                    completion(mainContents)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    // MARK: - 상위 카테고리 별 판매량 많은 순
    func getMainEventsCategoryRank(category: Int, completion: @escaping ([MainContents]?) -> Void) {
        
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/genre/\(category)/rank"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                switch response.result{
                case .success(let mainContents):
                    completion(mainContents)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    // MARK: - 전체 공연 중 티켓 오픈이 다가오는 순
    func getMainEventsOpenSoon(completion: @escaping ([MainContents]?) -> Void) {
        
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                switch response.result {
                case .success(let eventResponse):
                    completion(eventResponse)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    // MARK: - 하위 카테고리 별 공연 정보 가져오기
    func getSubCategoryEvents(subCategoryId: Int, completion: @escaping ([MainContents]?) -> Void) {
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/genre/\(subCategoryId)/events"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: EventResponse.self) { response in
                switch response.result {
                case .success(let eventResponse):
                    completion(eventResponse.content)
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
    // MARK: - 카테고리 별 오픈 예정 공연 정보 가져오기
    func getCategoryOpenSoonEvents(categoryId: Int, completion: @escaping ([MainContents]?) -> Void) {
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/genre/\(categoryId)/earliest-ticket"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [MainContents].self) { response in
                switch response.result{
                case .success(let mainContents):
                    completion(mainContents)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    // MARK: - 공연정보 관심 등록
    func addInterestEvent(eventInfoId: Int, completion: @escaping (Bool) -> Void) {
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/\(eventInfoId)/dibs"
        
        AF.request(mainEventUrl, method: .post, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        completion((200..<300).contains(httpResponse.statusCode))
                    } else {
                        print("No HTTP Response received.")
                        completion(false)
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Error: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(false)
                }
            }
    }
    // MARK: - 공연정보 관심 해제
    func removeInterestEvent(eventInfoId: Int, completion: @escaping (Bool) -> Void) {
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/\(eventInfoId)/dibs"
        
        AF.request(mainEventUrl, method: .delete, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        completion((200..<300).contains(httpResponse.statusCode))
                    } else {
                        print("No HTTP Response received.")
                        completion(false)
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Error: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                    completion(false)
                }
            }
    }
    // MARK: - 내 관심 공연정보 리스트 조회
    func getMyInterestEvents(completion: @escaping ([MyFavorites]?) -> Void) {
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/dibs"
        
        AF.request(mainEventUrl, method: .get, headers: Config().getHeaders())
            .validate()
            .responseDecodable(of: [MyFavorites].self) { response in
                switch response.result{
                case .success(let myFavorites):
                    completion(myFavorites)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
    // MARK: - 공연 정보 검색 결과 조회
    func searchEventInfo(searchWord: String, completion: @escaping ([SearchContents]?) -> Void) {
        let mainEventUrl = "\(Config().ServerHost)/api/v1/contents/search?searchWord=\(searchWord)"
        
        AF.request(mainEventUrl, method: .get)
            .validate()
            .responseDecodable(of: [SearchContents].self) { response in
                switch response.result{
                case .success(let searchResponse):
                    completion(searchResponse)
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
    }
}

