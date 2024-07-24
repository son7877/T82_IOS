import Foundation
import Alamofire

class CouponService {
    
    static let shared = CouponService()
    private init() {}
    
    // MARK: - 사용 가능한 쿠폰 리스트 가져오기
    func fetchCoupons(page: Int, size: Int, completion: @escaping (Result<CouponResponse, Error>) -> Void) {
        let urlString = Config().CouponHost+"/api/v1/coupons/valid"
        let parameters: Parameters = ["page": page, "size": size]
        
        AF.request(urlString, parameters: parameters, headers: Config().getHeaders()).responseDecodable(of: CouponResponse.self) { response in
            switch response.result {
            case .success(let couponResponse):
                completion(.success(couponResponse))
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
