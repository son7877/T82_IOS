import Foundation

class ReservationViewModel: ObservableObject {
    @Published var contentsDetail: ContentsDetail
    @Published var availableDates: [EventsByDate]
    @Published var availableSeats: [RestSeats]
    
    init(eventInfoId: Int) {
        self.contentsDetail = ContentsDetail(title: "", description: "", rating: 0.0, runningTime: "", ageRestriction: "", placeName: "", totalSeat: 0)
        self.availableDates = []
        self.availableSeats = []
        fetchContentDetail(eventInfoId: eventInfoId)
        fetchAvailableDates(eventInfoId: eventInfoId)
    }
    
    // 공연 상세 정보 가져오기
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
    
    // 공연 별 이벤트 시간 불러오기
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
    
    // 이벤트 별 남은 좌석 수 불러오기
//    func fetchAvailableSeats(eventInfoId: Int) {
//        ContentDetailService.shared.getRestSeatsByTime(eventId: eventId) { [weak self] availableSeats in
//            guard let self = self else { return }
//            if let availableSeats = availableSeats {
//                DispatchQueue.main.async {
//                    self.availableSeats = availableSeats
//                }
//            } else {
//                print("예약 가능한 좌석을 불러오지 못했습니다.")
//            }
//        }
//    }
}
