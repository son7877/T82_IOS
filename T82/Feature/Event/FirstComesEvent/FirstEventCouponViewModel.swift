import Foundation
import Combine

class FirstEventCouponViewModel: ObservableObject {
    
    @Published var couponEvent: [CouponEvent] = []
    
    // 쿠폰 이벤트 조회
    func fetchCouponEvent() {
        CouponService.shared.fetchCouponEvents { result in
            switch result {
            case .success(let couponEvent):
                DispatchQueue.main.async {
                    self.couponEvent = couponEvent
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // 이벤트 쿠폰 발급
    func issueEventCoupon(couponId: String, completion: @escaping (Bool) -> Void){
        CouponService.shared.issueEventCoupon(couponId: couponId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print("\(couponId) 쿠폰 발급 성공")
                    completion(success)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
