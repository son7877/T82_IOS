//
//  Coupons.swift
//  T82
//
//  Created by 안홍범 on 7/11/24.
//

import Foundation

struct Coupons : Hashable {
    var couponName: String
    var discountType: Double
    var discountValue: Int
    
    init(couponName: String, discountType: Double, discountValue: Int) {
        self.couponName = couponName
        self.discountType = discountType
        self.discountValue = discountValue
    }
    
}
