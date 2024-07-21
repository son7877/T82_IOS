import Foundation

class ReservationViewModel: ObservableObject {
    @Published var contentsDetail: ContentsDetail
    
    init(eventId: Int) {
        self.contentsDetail = ContentsDetail(title: "", description: "", rating: 0.0, runningTime: "", ageRestriction: "", placeName: "", totalSeat: 0)
        fetchContentDetail(eventId: eventId)
    }
    
    func fetchContentDetail(eventId: Int) {
        ContentDetailService.shared.getContentDetail(eventId: eventId) { [weak self] contentsDetail in
            guard let self = self else { return }
            if let contentsDetail = contentsDetail {
                self.contentsDetail = contentsDetail
            } else {
                // 오류 처리
                print("상세 정보를 불러오지 못했습니다.")
            }
        }
    }
}
