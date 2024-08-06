import Foundation
import Alamofire

class ReviewService {
    
    static let shared = ReviewService()
    private init() {}
    
    // MARK: - 리뷰 작성
    func addReview(reviewRequest: MyReview, completion: @escaping (Bool, String?) -> Void) {
        let writeUrl = "\(Config().AuthHost)/api/v1/reviews"
        
        let parameters = [
            "eventInfoId": reviewRequest.eventInfoId,
            "content": reviewRequest.content,
            "rating": reviewRequest.rating,
            "reviewPictureUrl": reviewRequest.reviewPictureUrl ?? ""
        ] as [String : Any]
                
        AF.request(writeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        completion((200..<300).contains(httpResponse.statusCode), nil)
                    } else {
                        print("No HTTP Response received.")
                        completion(false, "No HTTP Response received.")
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Error: \(httpResponse.statusCode)")
                        if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                            print("Error Message: \(errorMessage)")
                            completion(false, errorMessage)
                        } else {
                            completion(false, "Unknown error occurred.")
                        }
                    } else {
                        print("Network Error: \(error.localizedDescription)")
                        completion(false, error.localizedDescription)
                    }
                }
            }
    }

    
    // MARK: - 내 리뷰 조회
    func getMyReviews(completion: @escaping ([MyReview]?) -> Void) {
        let urlString = "\(Config().AuthHost)/api/v1/reviews"
        
        AF.request(urlString, headers: Config().getHeaders()).responseDecodable(of: [MyReview].self) { response in
            switch response.result {
            case .success(let myReviews):
                completion(myReviews)
            case .failure(let error):
                if let httpResponse = response.response {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Error Message: \(errorMessage)")
                    }
                    print("Network Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
