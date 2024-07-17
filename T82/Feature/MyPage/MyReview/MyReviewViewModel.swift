//
//  MyReviewViewModel.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import Foundation

class MyReviewViewModel: ObservableObject{
    
    @Published var MyReviews: [MyReview]
    
    // 예시 데이터
    init(
        MyReviews: [MyReview] = [
            MyReview(content: "너무 좋아요", rating: 5, reviewDate: Date()),
            MyReview(content: "별로에요", rating: 2, reviewDate: Date())
        ]
    ){
        self.MyReviews = MyReviews
    }
}
