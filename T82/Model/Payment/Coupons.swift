import Foundation

struct Coupon: Codable, Identifiable {
    let couponId: String
    let couponName: String
    let discountType: String
    let discountValue: Int
    let validEnd: String
    let minPurchase: Int
    let duplicate: Bool
    let category: String
    
    var id : String {
        return couponId
    }
}
