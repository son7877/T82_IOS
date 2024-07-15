import SwiftUI

class SeatsViewModel: ObservableObject {
    
    @Published var seats: [[Seat]] = []

    init() {
        loadSeats()
    }

    // 예시 데이터
    func loadSeats() {
        self.seats = [
            [Seat(row: "B", number: 1, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "B", number: 2, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "B", number: 3, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "B", number: 4, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "B", number: 5, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "B", number: 6, section: "SR", isSelected: false, isAvailable: true)],
            
            [Seat(row: "C", number: 1, section: "SR", isSelected: false, isAvailable: false),
             Seat(row: "C", number: 2, section: "SR", isSelected: false, isAvailable: false),
             Seat(row: "C", number: 3, section: "SR", isSelected: false, isAvailable: false),
             Seat(row: "C", number: 4, section: "SR", isSelected: false, isAvailable: false),
             Seat(row: "C", number: 5, section: "SR", isSelected: false, isAvailable: false),
             Seat(row: "C", number: 6, section: "SR", isSelected: false, isAvailable: false)],
            
            [Seat(row: "D", number: 1, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "D", number: 2, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "D", number: 3, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "D", number: 4, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "D", number: 5, section: "SR", isSelected: false, isAvailable: true),
             Seat(row: "D", number: 6, section: "SR", isSelected: false, isAvailable: true)],
            
            [Seat(row: "E", number: 1, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "E", number: 2, section: "R", isSelected: false, isAvailable: false),
             Seat(row: "E", number: 3, section: "R", isSelected: false, isAvailable: false),
             Seat(row: "E", number: 4, section: "R", isSelected: false, isAvailable: false),
             Seat(row: "E", number: 5, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "E", number: 6, section: "R", isSelected: false, isAvailable: true)],
            
            [Seat(row: "F", number: 1, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "F", number: 2, section: "R", isSelected: false, isAvailable: false),
             Seat(row: "F", number: 3, section: "R", isSelected: false, isAvailable: false),
             Seat(row: "F", number: 4, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "F", number: 5, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "F", number: 6, section: "R", isSelected: false, isAvailable: true)],
            
            [Seat(row: "G", number: 1, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "G", number: 2, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "G", number: 3, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "G", number: 4, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "G", number: 5, section: "R", isSelected: false, isAvailable: true),
             Seat(row: "G", number: 6, section: "R", isSelected: false, isAvailable: true)],
            
            [Seat(row: "H", number: 1, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "H", number: 2, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "H", number: 3, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "H", number: 4, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "H", number: 5, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "H", number: 6, section: "S", isSelected: false, isAvailable: false)],
            
            [Seat(row: "I", number: 1, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "I", number: 2, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "I", number: 3, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "I", number: 4, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "I", number: 5, section: "S", isSelected: false, isAvailable: false),
             Seat(row: "I", number: 6, section: "S", isSelected: false, isAvailable: false)]
        ]
    }
    
    func toggleSeatSelection(seat: Seat) {
        if let rowIndex = seats.firstIndex(where: { row in
            row.contains(where: { $0.id == seat.id })
        }), let seatIndex = seats[rowIndex].firstIndex(where: { $0.id == seat.id }) {
            seats[rowIndex][seatIndex].isSelected.toggle()
            objectWillChange.send()
        }
    }
}
