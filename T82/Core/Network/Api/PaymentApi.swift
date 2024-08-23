import Foundation
import Alamofire

class CouponService {
    
    static let shared = CouponService()
    private init() {}
    
    // MARK: - 사용 가능한 쿠폰 리스트 가져오기
    func fetchCoupons(completion: @escaping (Result<[Coupon], Error>) -> Void) {
        
        let urlString = Config().ServerHost+"/api/v1/coupons/valid"
        
        AF.request(urlString, headers: Config().getHeaders()).responseDecodable(of: [Coupon].self) { response in
            switch response.result {
            case .success(let coupon):
                completion(.success(coupon))
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
    // MARK: - 진행 중인 선착순 쿠폰 이벤트 가져오기
    func fetchCouponEvents(completion: @escaping(Result<[CouponEvent], Error>) -> Void) {
        
        let url = Config().ServerHost+"/api/v1/coupons/events"
        
        AF.request(url, method: .get).responseDecodable(of: [CouponEvent].self) { response in
            switch response.result {
            case .success(let couponEvents):
                completion(.success(couponEvents))
            case .failure(let error):
                if let httpResponse = response.response {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
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
    // MARK: - 이벤트 쿠폰 발급
    func issueEventCoupon(couponId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let url = Config().ServerHost + "/api/v1/coupons/events/issue"
        
        let parameters: [String: Any] = ["couponId": couponId]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Config().getHeaders())
            .validate(statusCode: 200..<300)
            .response { response in
            switch response.result {
            case .success:
                completion(.success(true))
                print("이벤트 쿠폰 발급 성공")
            case .failure(let error):
                if let httpResponse = response.response {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
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
    // MARK: - 만보기 쿠폰 조회
    func getPedometerCoupons(completion: @escaping(Result<[Coupon], Error>) -> Void) {
        
        let url = Config().ServerHost+"/api/v1/coupons?category=PEDOMETER"
        
        AF.request(url, method: .get, headers: Config().getHeaders()).responseDecodable(of: [Coupon].self) { response in
            switch response.result {
            case .success(let coupons):
                completion(.success(coupons))
            case .failure(let error):
                if let httpResponse = response.response {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
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
}


class PaymentService {
    
    static let shared = PaymentService()
    private init() {}
    
    // MARK: - 결제하기(토스 연동)
    func tossPayment(paymentRequest: PaymentRequest, completion: @escaping (Result<PaymentResponse, Error>) -> Void) {
        
        let urlString = Config().ServerHost + "/api/v1/payment"

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
    // MARK: - 결제하기 (Click!)
    
    
    // MARK: - 환불 기능
    func requestRefund(refundRequest: Refund, completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = Config().ServerHost + "/api/v1/refund"
        
        AF.request(urlString, method: .post, parameters: refundRequest, encoder: JSONParameterEncoder.default, headers: Config().getHeaders()).response { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                if let httpResponse = response.response {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
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
}
