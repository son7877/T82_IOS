import Foundation
import SwiftUI

class ReservationViewModel: ObservableObject {
    @Published var contentsDetail: ContentsDetail
    @Published var availableDates: [EventsByDate]
    @Published var availableSeats: [RestSeats]
    @Published var seatsFetchError: Bool = false
    @AppStorage("userID") private var userID: String = "defaultUserID" // 로그인 시 설정된 userID를 사용

    // 관심 등록 상태 관리
    @Published var isInterested: Bool = false
    let eventInfoId: Int
    private var interestKey: String {
        return "interest_\(userID)_\(eventInfoId)"
    }

    init(eventInfoId: Int) {
        self.contentsDetail = ContentsDetail(title: "", description: "", rating: 0.0, runningTime: "", ageRestriction: "", placeName: "", placeId: 1, totalSeat: 0, imageUrl: "")
        self.availableDates = []
        self.availableSeats = []
        self.eventInfoId = eventInfoId

        // 관심 상태를 불러와 설정
        self.isInterested = UserDefaults.standard.bool(forKey: interestKey)

        fetchContentDetail(eventInfoId: eventInfoId)
        fetchAvailableDates(eventInfoId: eventInfoId)
    }

    // MARK: - 공연 상세 정보 가져오기
    func fetchContentDetail(eventInfoId: Int) {
        ContentDetailService.shared.getContentDetail(eventInfoId: eventInfoId) { [weak self] contentsDetail in
            guard let self = self else { return }
            if let contentsDetail = contentsDetail {
                self.contentsDetail = contentsDetail
            } else {
                print("상세 정보를 불러오지 못했습니다.")
            }
        }
    }

    // MARK: - 공연 별 이벤트 시간 불러오기
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

    // MARK: - 이벤트 별 남은 좌석 수 불러오기
    func fetchAvailableSeats(eventId: Int) {
        ContentDetailService.shared.getRestSeatsByTime(eventId: eventId) { [weak self] availableSeats in
            guard let self = self else { return }
            if let availableSeats = availableSeats {
                DispatchQueue.main.async {
                    self.availableSeats = availableSeats
                    self.seatsFetchError = false
                }
            } else {
                DispatchQueue.main.async {
                    self.availableSeats = []
                    self.seatsFetchError = true
                }
                print("예약 가능한 좌석을 불러오지 못했습니다.")
            }
        }
    }
    
    func getAvailableSeatsCountString() -> String {
        return availableSeats.map { "\($0.name): \($0.restSeat)석" }.joined(separator: " / ")
    }

    // MARK: - 공연 관심 등록
    func addInterest() {
        isInterested = true
        UserDefaults.standard.set(true, forKey: interestKey)
        print("Added interest for key: \(interestKey)")
        let savedInterest = UserDefaults.standard.bool(forKey: interestKey)
        print("Saved interest: \(savedInterest)")
    }

    // MARK: - 공연 관심 해제
    func removeInterest() {
        isInterested = false
        UserDefaults.standard.set(false, forKey: interestKey)
        print("Removed interest for key: \(interestKey)")
    }
}
