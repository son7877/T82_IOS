//
//  MyReview.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

struct MyReview: Hashable{
    var content: String
    var rating: Int
    var reviewDate: Date
    
    init(content: String, rating: Int, reviewDate: Date) {
        self.content = content
        self.rating = rating
        self.reviewDate = reviewDate
    }
}
