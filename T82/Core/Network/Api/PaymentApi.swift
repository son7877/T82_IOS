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

class PaymentService {
    
    static let shared = PaymentService()
    private init() {}
    
    // MARK: - 결제하기(토스 연동)
    func tossPayment(paymentRequest: PaymentRequest, completion: @escaping (Result<PaymentResponse, Error>) -> Void) {
        
        let urlString = Config().PaymentHost + "/api/v1/payment"

        AF.request(urlString, method: .post, parameters: paymentRequest, encoder: JSONParameterEncoder.default, headers: Config().getHeaders()).response { response in
            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                print("Raw Response Data: \(dataString)")

                // 응답이 URL 문자열인지 확인
                if dataString.starts(with: "https://ul.toss.im") {
                    let paymentResponse = PaymentResponse(success: true, message: dataString, paymentURL: dataString)
                    completion(.success(paymentResponse))
                    return
                }
            }

            switch response.result {
            case .success:
                do {
                    let paymentResponse = try JSONDecoder().decode(PaymentResponse.self, from: response.data!)
                    if let urlString = paymentResponse.message, urlString.starts(with: "https://ul.toss.im") {
                        completion(.success(PaymentResponse(success: true, message: paymentResponse.message, paymentURL: urlString)))
                    } else {
                        completion(.success(paymentResponse))
                    }
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                if let httpResponse = response.response {
                    print("ERROR: HTTP Status Code: \(httpResponse.statusCode)")
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
    
    // MARK: - 환불 기능
    
    
}
