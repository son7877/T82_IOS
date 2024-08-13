import Foundation

class MyReviewViewModel: ObservableObject {
    
    @Published var MyReviews: [MyReview] = []
    @Published var isLoading = false
    @Published var reviewSubmissionSuccess = false
    @Published var reviewSubmissionError: String = ""
    
    // 내 리뷰 조회
    func fetchMyReview() {
        isLoading = true
        ReviewService.shared.getMyReviews { result in
            switch result {
            case .success(let reviews):
                self.MyReviews = reviews
                self.isLoading = false
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
    
    // 리뷰 작성
    func addReview(reviewRequest: MyReview) {
        ReviewService.shared.addReview(reviewRequest: reviewRequest) { result in
            switch result {
            case .success:
                self.reviewSubmissionSuccess = true
            case .failure(let error):
                self.reviewSubmissionError = error.localizedDescription
            }
        }
    }
    
    // 리뷰 이미지 등록
    
}
