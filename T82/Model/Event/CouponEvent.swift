import Foundation

struct CouponEvent: Decodable, Identifiable {
    var couponId: String
    var couponName: String
    var discountType: String
    var discountValue: Int
    var validEnd: String
    var minPurchase: Int
    var duplicate: Bool
    var category: String
    
    var id : String {
        return couponId
    }
}
