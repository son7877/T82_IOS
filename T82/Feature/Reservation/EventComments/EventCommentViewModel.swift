import Foundation

class EventCommentViewModel: ObservableObject {
    
    @Published var eventInfoReviews: [EventInfoReviews] = []
    @Published var replies: [Replies] = []
    @Published var isLoading = false
    @Published var reviewSubmissionSuccess = false
    @Published var reviewSubmissionError: String = ""
    
    // EventInfo별 리뷰 조회
    func fetchEventInfoReviews(eventInfoId: Int) {
        isLoading = true
        ReviewService.shared.getEventInfoReviews(eventInfoId: eventInfoId) { result in
            switch result {
            case .success(let reviews):
                self.eventInfoReviews = reviews
                self.isLoading = false
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
    
    // 대댓글 조회
    func fetchReplies(reviewId: Int) {
        isLoading = true
        ReviewService.shared.getReplies(reviewId: reviewId) { result in
            switch result {
            case .success(let replies):
                self.replies = replies
                self.isLoading = false
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
    
    // 대댓글 작성 후 새로고침
    func addReplies(reviewId: Int, content: String) {
        ReviewService.shared.addReplies(reviewId: reviewId, content: content) { result in
            switch result {
            case .success:
                self.reviewSubmissionSuccess = true
                self.fetchReplies(reviewId: reviewId)
            case .failure(let error):
                self.reviewSubmissionError = error.localizedDescription
            }
        }
    }
    
    // 대댓글 삭제
    func deleteReplies(reviewId: Int, commentId: Int) {
        ReviewService.shared.deleteReplies(reviewId: reviewId, commentId: commentId) { result in
            switch result {
            case .success:
                self.fetchReplies(reviewId: reviewId)
            case .failure(let error):
                self.reviewSubmissionError = error.localizedDescription
            }
        }
    }
}
