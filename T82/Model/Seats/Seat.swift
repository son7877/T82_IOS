import Foundation

struct Seat: Identifiable, Hashable {
    let id = UUID()
    let row: String
    let number: Int
    let section: String
    var isSelected: Bool
    let isAvailable: Bool
}
