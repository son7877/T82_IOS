//
//  DiscountedEvent.swift
//  T82
//
//  Created by 안홍범 on 7/18/24.
//

import Foundation

struct DiscountedEvents: Hashable {
    let eventId: Int
//    var imageName: String
    var title: String
    var rating: Double
    var discountRate: Double
    var discountedPrice: Int
    
    init(
        eventId: Int,
//        imageName: String,
        title: String,
        rating: Double,
        discountRate: Double,
        discountedPrice: Int) {
        self.eventId = eventId
//        self.imageName = imageName
        self.title = title
        self.rating = rating
        self.discountRate = discountRate
        self.discountedPrice = discountedPrice
    }
}
