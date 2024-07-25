import SwiftUI

class SeatsViewModel: ObservableObject {
    
    @Published var seats: [[Seat]] = []
    @Published var selectableSeats: [SelectableSeat] = []
    @Published var selectedSeats: [SelectableSeat] = []

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

    // 좌석 정보 -> fetch로 선택 가능한 좌석 정보를 가져오고 그 좌석의 isAvailable을 true로 바꿔야함
    func loadSeats() {
        self.seats = [
            // 10 * 10형태, 행 열 번호 0부터 시작
            (0..<10).map { Seat(id: $0, rowNum: 0, colNum: $0, name: "A구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 10, rowNum: 1, colNum: $0, name: "A구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 20, rowNum: 2, colNum: $0, name: "A구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 30, rowNum: 3, colNum: $0, name: "B구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 40, rowNum: 4, colNum: $0, name: "B구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 50, rowNum: 5, colNum: $0, name: "B구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 60, rowNum: 6, colNum: $0, name: "B구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 70, rowNum: 7, colNum: $0, name: "C구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 80, rowNum: 8, colNum: $0, name: "C구역", isSelected: false, isAvailable: false) },
            (0..<10).map { Seat(id: $0 + 90, rowNum: 9, colNum: $0, name: "C구역", isSelected: false, isAvailable: false) }
        ]
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
            seats[rowIndex][seatIndex].isSelected.toggle()
            print("Toggled seat selection: \(seats[rowIndex][seatIndex])")  // 확인용
            
            updateSelectedSeats()
        }
    }

    private func updateSelectedSeats() {
        selectedSeats = seats.flatMap { $0.filter { $0.isSelected } }.compactMap { seat in
            selectableSeats.first { $0.rowNum == seat.rowNum && $0.colNum == seat.colNum }
        }
        print("Updated selected seats: \(selectedSeats)")  // 확인용
    }
}
