//
//  MyReview.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

struct MyReview: Hashable, Identifiable{
    
    var id: Int
    var eventTitle: String
    var content: String
    var rating: Int
    var reviewDate: Date
    
    init(id:Int, eventTitle:String ,content: String, rating: Int, reviewDate: Date) {
        
        self.id = id
        self.eventTitle  = eventTitle
        self.content = content
        self.rating = rating
        self.reviewDate = reviewDate
    }
}
