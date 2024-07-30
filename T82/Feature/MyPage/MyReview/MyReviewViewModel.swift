import Foundation

class MyReviewViewModel: ObservableObject{
    
    @Published var MyReviews: [MyReview] = []
    @Published var isLoading = false
    
    init() {
        fetchMyReview()
    }
    
    func fetchMyReview(){
        isLoading = true
        ReviewService.shared.getMyReviews { [weak self] myReviews in
            guard let self = self else { return }
            if let myReviews = myReviews {
                self.MyReviews = myReviews
                isLoading = false
            } else {
                print("Failed to fetch reviews")
                isLoading = false
            }
        }
    }
}
