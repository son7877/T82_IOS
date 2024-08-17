import Foundation

class SeatsViewModel: ObservableObject {
    
    @Published var seats: [[Seat]] = []
    @Published var selectableSeats: [SelectableSeat] = []
    @Published var selectedSeats: [SelectableSeat] = []
    @Published var pendingSeats: [PendingSeat] = []
    @Published var showMaxSeatsAlert: Bool = false
    @Published var showWebView: Bool = false
    @Published var htmlContent: String = ""  // 추가된 부분

    
    // MARK: - 이벤트 별 남은 좌석 수 불러오기
    func fetchAvailableSeats(eventId: Int) {
        SelectSeatService.shared.getSelectableSeats(eventId: eventId) { [weak self] selectableSeats in
            guard let self = self else { return }
            if let selectableSeats = selectableSeats {
                DispatchQueue.main.async {
                    self.selectableSeats = selectableSeats
                    self.updateSeatAvailability()
                }
            } else {
                DispatchQueue.main.async {
                    self.selectableSeats = []
                }
            }
        }
    }
    
    // MARK: - 좌석 선택 후 결제 페이지로 이동할 시 결제 전까지 Pending 테이블에 추가
    func addPendingSeat(seats: [PendingSeat]){
        SelectSeatService.shared.addPendingSeats(seats: seats) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(true):
                DispatchQueue.main.async {
                    self.pendingSeats = seats
                }
            case .success(false):
                print("좌석 추가 실패: 알 수 없는 이유.")
            case .failure(let error):
                print("오류: \(error.localizedDescription)")
            }
        }
    }

    func loadSeats(for placeId: Int) {
        var totalSeats: Int
        switch placeId {
        case 1:
            totalSeats = 10
        case 2:
            totalSeats = 30
        case 3:
            totalSeats = 50
        default:
            totalSeats = 15 // 기본값
        }

        let sections = ["A구역", "B구역", "C구역"]
        let seatsPerSection = totalSeats / 3
        let remainder = totalSeats % 3

        self.seats = sections.enumerated().map { index, sectionName in
            let rowCount = seatsPerSection + (index < remainder ? 1 : 0)
            return (1...rowCount).map { row in
                Seat(id: row + index * rowCount, rowNum: row, colNum: index + 1, name: sectionName, isSelected: false, isAvailable: false)
            }
        }.compactMap { $0 }
        
        updateSeatAvailability() // 좌석의 사용 가능 여부를 업데이트
    }


    // 좌석의 사용 가능 여부를 업데이트
    func updateSeatAvailability() {
        for selectableSeat in selectableSeats {
            if let rowIndex = seats.firstIndex(where: { row in
                row.contains(where: { $0.rowNum == selectableSeat.rowNum && $0.colNum == selectableSeat.colNum })
            }), let seatIndex = seats[rowIndex].firstIndex(where: { $0.rowNum == selectableSeat.rowNum && $0.colNum == selectableSeat.colNum }) {
                seats[rowIndex][seatIndex].isAvailable = true
            }
        }
        objectWillChange.send()
    }
    
    // 좌석 선택 토글
    func toggleSeatSelection(seat: Seat) {
        if let rowIndex = seats.firstIndex(where: { row in
            row.contains(where: { $0.id == seat.id })
        }), let seatIndex = seats[rowIndex].firstIndex(where: { $0.id == seat.id }) {
            // 좌석이 선택되고 최대 선택 개수에 도달했는지 확인
            if !seats[rowIndex][seatIndex].isSelected && selectedSeats.count >= 5 {
                showMaxSeatsAlert = true
                return  // 5개 이상의 좌석 선택을 허용하지 않음
            }
            seats[rowIndex][seatIndex].isSelected.toggle()
            print("좌석 선택 토글: \(seats[rowIndex][seatIndex])")  // 확인용
            
            updateSelectedSeats()
        }
    }

    private func updateSelectedSeats() {
        selectedSeats = seats.flatMap { $0.filter { $0.isSelected } }.compactMap { seat in
            selectableSeats.first { $0.rowNum == seat.rowNum && $0.colNum == seat.colNum }
        }
        print("선택된 좌석 업데이트: \(selectedSeats)")  // 확인용
    }
    
    // MARK: - 대기열 입장 및 웹 뷰 표시
    func enterAndDisplayWaitingQueue(eventId: Int) {
        SelectSeatService.shared.enterWaitingQueue(eventId: eventId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entered):
                if entered {
                    self.getWaitingQueue(eventId: eventId)
                }
            case .failure(let error):
                print("대기열 입장 실패: \(error.localizedDescription)")
            }
        }
    }
    
    // 웹 뷰 호출
    func getWaitingQueue(eventId: Int) {
        SelectSeatService.shared.getWaitingQueue(eventId: eventId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let html):
                DispatchQueue.main.async {
                    self.htmlContent = html
                    self.showWebView = true
                }
            case .failure(let error):
                print("대기열 웹 뷰 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    
    // 대기열 상태 호출
    func checkWaitingQueueStatus(eventId: Int) {
        SelectSeatService.shared.getWaitingStatus(eventId: eventId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let status = response.status
                print("대기열 상태: \(status)")
                if status == "ENDED" {
                    DispatchQueue.main.async {
                        self.showWebView = false
                    }
                }
            case .failure(let error):
                print("대기열 상태 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }
}



