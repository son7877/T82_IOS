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
            DispatchQueue.main.async {
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
    }
    
    // 리뷰 작성 및 이미지 등록
    func addReview(reviewRequest: MyReviewRequest, imageData: Data?) {
        
        // 이미지 데이터가 존재하면 먼저 이미지를 업로드
        if let imageData = imageData {
            uploadImageAndSubmitReview(reviewRequest: reviewRequest, imageData: imageData)
        } else {
            
            // 이미지가 없으면 바로 리뷰 등록
            submitReview(reviewRequest: reviewRequest)
        }
    }
    
    private func uploadImageAndSubmitReview(reviewRequest: MyReviewRequest, imageData: Data) {
        isLoading = true
        ReviewService.shared.uploadReviewImage(image: imageData) { [weak self] imageUrl in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let imageUrl = imageUrl {
                    print("imageUrl: \(imageUrl)")
                    
                    // 이미지 URL을 포함하여 리뷰 등록
                    var updatedRequest = reviewRequest
                    updatedRequest.reviewPictureUrl = imageUrl
                    self.submitReview(reviewRequest: updatedRequest)
                } else {
                    self.isLoading = false
                    self.reviewSubmissionError = "이미지 업로드에 실패했습니다."
                }
            }
        }
    }
    
    private func submitReview(reviewRequest: MyReviewRequest) {
        ReviewService.shared.addReview(reviewRequest: reviewRequest) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.reviewSubmissionSuccess = true
                case .failure(let error):
                    self.reviewSubmissionError = error.localizedDescription
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
