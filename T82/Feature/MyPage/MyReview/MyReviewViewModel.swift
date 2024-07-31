import Foundation

class MyReviewViewModel: ObservableObject {
    
    @Published var MyReviews: [MyReview] = []
    @Published var isLoading = false
    @Published var reviewSubmissionSuccess = false
    @Published var reviewSubmissionError: String? = nil
    
    
    // 내 리뷰 조회
    func fetchMyReview() {
        isLoading = true
        ReviewService.shared.getMyReviews { [weak self] myReviews in
            guard let self = self else { return }
            if let myReviews = myReviews {
                self.MyReviews = myReviews
                self.isLoading = false
            } else {
                print("내 리뷰 조회 실패")
                self.isLoading = false
            }
        }
    }
    
    // 리뷰 작성
    func addReview(reviewRequest: MyReview) {
        isLoading = true
        ReviewService.shared.addReview(reviewRequest: reviewRequest) { [weak self] success in
            guard let self = self else { return }
            self.isLoading = false
            if success {
                self.reviewSubmissionSuccess = true
                self.fetchMyReview()
            } else {
                self.reviewSubmissionError = "리뷰 작성 실패"
            }
        }
    }
}
