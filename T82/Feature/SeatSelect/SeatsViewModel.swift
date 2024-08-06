import Foundation

class SeatsViewModel: ObservableObject {
    
    @Published var seats: [[Seat]] = []
    @Published var selectableSeats: [SelectableSeat] = []
    @Published var selectedSeats: [SelectableSeat] = []
    @Published var pendingSeats: [PendingSeat] = []
    @Published var showMaxSeatsAlert: Bool = false

    init() {
        loadSeats()
    }
    
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

    // 좌석 정보 -> fetch로 선택 가능한 좌석 정보를 가져오고 그 좌석의 isAvailable을 true로 바꿔야함
    func loadSeats() {
        self.seats = (1...15).map { row in
            let sectionName: String
            switch row {
            case 1...5:
                sectionName = "A구역"
            case 6...10:
                sectionName = "B구역"
            case 11...15:
                sectionName = "C구역"
            default:
                sectionName = "Unknown"
            }
            return (1...100).map { col in
                Seat(id: (row - 1) * 100 + col, rowNum: row, colNum: col, name: sectionName, isSelected: false, isAvailable: false)
            }
        }
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
}
