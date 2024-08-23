import Foundation

class SeatsViewModel: ObservableObject {
    
    @Published var seats: [[Seat]] = []
    @Published var selectableSeats: [SelectableSeat] = []
    @Published var selectedSeats: [SelectableSeat] = []
    @Published var pendingSeats: [PendingSeat] = []
    @Published var showMaxSeatsAlert: Bool = false
    @Published var showWebView: Bool = false
    @Published var htmlContent: String = ""
    @Published var showAlert: Bool = false
    var alertMessage: String = ""  // 알림 메시지 저장

    
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
                DispatchQueue.main.async {
                    self.alertMessage = "좌석 추가에 실패했습니다. 다시 시도해 주세요."
                    self.showAlert = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.alertMessage = "이미 선택된 좌석입니다."
                    self.showAlert = true
                }
            }
        }
    }

    func loadSeats(for placeId: Int) {
        var totalSeats: Int
        var sections: [(name: String, ratio: Int)] = []

        switch placeId {
        case 1:
            totalSeats = 10
            sections = [("일반석", 1)]
            
        case 2:
            totalSeats = 50
            sections = [("VIP", 2), ("일반석", 3)]
            
        case 3:
            totalSeats = 100
            sections = [("VIP", 2), ("S석", 2), ("A석", 2), ("B석", 4)]
            
        default:
            totalSeats = 0
        }

        var seatId = 1
        var allSeats: [[Seat]] = []

        for section in sections {
            let seatsInThisSection = (totalSeats * section.ratio) / sections.map { $0.ratio }.reduce(0, +)
            
            var sectionSeats: [Seat] = []
            
            for seatNumber in 1...seatsInThisSection {
                let rowNum = (seatNumber - 1) / 10 + 1
                let colNum = (seatNumber - 1) % 10 + 1
                let seat = Seat(id: seatId, rowNum: rowNum, colNum: colNum, name: section.name, isSelected: false, isAvailable: false)
                seatId += 1
                sectionSeats.append(seat)

                // 10개씩 끊어서 새로운 행으로 추가
                if sectionSeats.count == 10 {
                    allSeats.append(sectionSeats)
                    sectionSeats = []
                }
            }

            // 나머지 좌석이 있으면 추가
            if !sectionSeats.isEmpty {
                allSeats.append(sectionSeats)
            }
        }

        self.seats = allSeats
    }

    // 좌석의 사용 가능 여부를 업데이트
    func updateSeatAvailability() {
        for selectableSeat in selectableSeats {
            for rowIndex in 0..<seats.count {
                if let seatIndex = seats[rowIndex].firstIndex(where: { $0.rowNum == selectableSeat.rowNum && $0.colNum == selectableSeat.colNum }) {
                    seats[rowIndex][seatIndex].isAvailable = true
                }
            }
        }
        objectWillChange.send()
    }
    
    // 좌석 선택 토글
    func toggleSeatSelection(seat: Seat) {
        if let rowIndex = seats.firstIndex(where: { row in
            row.contains(where: { $0.id == seat.id })
        }), let seatIndex = seats[rowIndex].firstIndex(where: { $0.id == seat.id }) {
            seats[rowIndex][seatIndex].isSelected.toggle()
            print("Toggled seat selection: \(seats[rowIndex][seatIndex])")  // 디버깅용 로그 추가
            
            updateSelectedSeats()
        }
    }


    private func updateSelectedSeats() {
        selectedSeats = seats.flatMap { $0.filter { $0.isSelected } }.compactMap { seat in
            if let matchingSelectableSeat = selectableSeats.first(where: {
                $0.rowNum == seat.rowNum && $0.colNum == seat.colNum
            }) {
                // 선택된 좌석의 name을 seat의 name으로 대체하여 반환
                return SelectableSeat(seatId: matchingSelectableSeat.seatId,
                                      rowNum: matchingSelectableSeat.rowNum,
                                      colNum: matchingSelectableSeat.colNum,
                                      name: seat.name,
                                      price: matchingSelectableSeat.price
                )
            }
            return nil
        }
        print("Updated selected seats: \(selectedSeats)")
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



