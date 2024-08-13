import Foundation
import Combine

class CouponListViewModel: ObservableObject {
    @Published var coupons: [Coupon] = []
    @Published var isLoading = false
    @Published var couponList: [Int: Coupon] = [:]
    @Published var isShowDiscount: Bool = false
    @Published var usedCoupons: Set<String> = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCoupons() {
        guard !isLoading else { return }
        isLoading = true
        
        CouponService.shared.fetchCoupons() { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.coupons = response
                print("쿠폰 불러오기 성공")
                print("쿠폰 리스트: \(self.coupons)")
            case .failure(let error):
                print("쿠폰 불러오기 실패: \(error)")
            }
        }
    }
}
