import Foundation

class ReservationViewModel: ObservableObject {
    @Published var contentsDetail: ContentsDetail
    @Published var availableDates: [EventsByDate]
    
    init(eventInfoId: Int) {
        self.contentsDetail = ContentsDetail(title: "", description: "", rating: 0.0, runningTime: "", ageRestriction: "", placeName: "", totalSeat: 0)
        self.availableDates = []
        fetchContentDetail(eventInfoId: eventInfoId)
        fetchAvailableDates(eventInfoId: eventInfoId)
    }
    
    func fetchContentDetail(eventInfoId: Int) {
        ContentDetailService.shared.getContentDetail(eventInfoId: eventInfoId) { [weak self] contentsDetail in
            guard let self = self else { return }
            if let contentsDetail = contentsDetail {
                self.contentsDetail = contentsDetail
            } else {
                // 오류 처리
                print("상세 정보를 불러오지 못했습니다.")
            }
        }
    }
    
    func fetchAvailableDates(eventInfoId: Int) {
        ContentDetailService.shared.getAvailableDates(eventInfoId: eventInfoId) { [weak self] availableDates in
            guard let self = self else { return }
            if let availableDates = availableDates {
                DispatchQueue.main.async {
                    self.availableDates = availableDates
                }
            } else {
                print("예약 가능한 날짜를 불러오지 못했습니다.")
            }
        }
    }
    
    func availableTimes(for date: Date) -> [Date] {
        return availableDates.filter { Calendar.current.isDate($0.eventStartTime, inSameDayAs: date) }.map { $0.eventStartTime }
    }
}
