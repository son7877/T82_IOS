import Foundation
import Combine

class CouponListViewModel: ObservableObject {
    @Published var coupons: [Coupon] = []
    @Published var isLoading = false
    @Published var couponList: [Int: Coupon] = [:]
    @Published var isShowDiscount: Bool = false
    @Published var usedCoupons: Set<String> = [] // 사용 중인 쿠폰 ID를 저장할 집합

    private var currentPage = 0
    private var totalPages = 1
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCoupons(page: currentPage, size: 5)
    }
    
    func fetchCoupons(page: Int, size: Int) {
        guard !isLoading else { return }
        isLoading = true
        
        CouponService.shared.fetchCoupons(page: page, size: size) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.coupons.append(contentsOf: response.content)
                self.totalPages = response.totalPages
                self.currentPage = response.number
                print("쿠폰 불러오기 성공")
                print("쿠폰 리스트: \(self.coupons)")
            case .failure(let error):
                print("쿠폰 불러오기 실패: \(error)")
            }
        }
    }
    
    func loadMoreCouponsIfNeeded(currentItem: Coupon) {
        guard !isLoading else { return }
        
        let thresholdIndex = coupons.index(coupons.endIndex, offsetBy: -5)
        if coupons.firstIndex(where: { $0.couponId == currentItem.couponId }) == thresholdIndex {
            fetchCoupons(page: currentPage + 1, size: 5)
        }
    }
}
