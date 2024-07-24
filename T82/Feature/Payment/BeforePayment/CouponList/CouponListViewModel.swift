import Foundation
import Combine

class CouponListViewModel: ObservableObject {
    @Published var coupons: [Coupon] = []
    @Published var isLoading = false
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
            case .failure(let error):
                print("Failed to fetch coupons: \(error)")
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
