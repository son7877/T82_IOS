import Foundation

struct CouponResponse: Codable {
    let totalPages: Int
    let totalElements: Int
    let first: Bool
    let last: Bool
    let size: Int
    let content: [Coupon]
    let number: Int
    let numberOfElements: Int
    let pageable: Pageable
    let empty: Bool
}

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

struct Pageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: Sort
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}

struct Sort: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}
