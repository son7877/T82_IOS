import Foundation

class MyReviewViewModel: ObservableObject{
    
    @Published var MyReviews: [MyReview]
    
    // 예시 데이터
    init(
        MyReviews: [MyReview] = [
            MyReview(id: 1,eventTitle: "싸이 흠뻑쇼" ,content: "너무 좋아요", rating: 5, reviewDate: Date()),
            MyReview(id: 2,eventTitle: "LG vs 두산" ,content: "좋아요", rating: 4, reviewDate: Date()),]
    ){
        self.MyReviews = MyReviews
    }
}
