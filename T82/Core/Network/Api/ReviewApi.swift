import Foundation
import Alamofire

class ReviewService {
    
    static let shared = ReviewService()
    private init() {}
    
    // MARK: - 리뷰 작성
    func addReview(
        reviewRequest: MyReviewRequest
        ,completion: @escaping (Result<Bool, Error>) -> Void) {
        let writeUrl = "\(Config().ServerHost)/api/v1/reviews"
        
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
                    completion(.success(true))
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("Review Error: \(error.localizedDescription)")
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
    // MARK: - 내 리뷰 조회
    func getMyReviews(completion: @escaping (Result<[MyReview], Error>) -> Void) {
        let url = "\(Config().ServerHost)/api/v1/reviews"
        
        AF.request(url, headers: Config().getHeaders()).responseDecodable(of: [MyReview].self) { response in
            switch response.result {
            case .success(let myReviews):
                completion(.success(myReviews))
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
    // MARK: - EventInfo별 리뷰 조회
    func getEventInfoReviews(eventInfoId: Int, completion: @escaping (Result<[EventInfoReviews], Error>) -> Void) {
        let url = "\(Config().ServerHost)/api/v1/reviews/\(eventInfoId)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [EventInfoReviews].self){ response in
            switch response.result {
            case .success(let eventInfoReviews):
                completion(.success(eventInfoReviews))
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
    
    // MARK: - 대댓글 작성
    func addReplies(reviewId: Int, content: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(Config().ServerHost)/api/v1/\(reviewId)/comments"
        
        let parameters = [
            "content": content
        ] as [String : Any]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("Review Error: \(error.localizedDescription)")
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
    // MARK: - 대댓글 조회
    func getReplies(reviewId: Int, completion: @escaping (Result<[Replies], Error>) -> Void) {
        let url = "\(Config().ServerHost)/api/v1/\(reviewId)/comments"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [Replies].self){ response in
            switch response.result {
            case .success(let replies):
                completion(.success(replies))
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

    // MARK: - 대댓글 삭제
    func deleteReplies(reviewId:Int, commentId: Int, completion: @escaping (Result<Bool, Error>) -> Void){
        
        let url = "\(Config().ServerHost)/api/v1/\(reviewId)/comments/\(commentId)"
        
        AF.request(url, method: .delete, headers: Config().getHeaders())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("Review Error: \(error.localizedDescription)")
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
    
    // MARK: - 리뷰 이미지 등록(formData)
    func uploadReviewImage(image: Data, completion: @escaping (String?) -> Void) {
        let uploadUrl = "https://awhxw5gg3j.execute-api.ap-northeast-2.amazonaws.com/default/review-image"
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to: uploadUrl, headers:Config().getImageHeaders())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let imageUrl = json["url"] as? String {
                    completion(imageUrl)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                print("Image upload failed with error: \(error)")
                completion(nil)
            }
        }
    }
}
