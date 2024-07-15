import SwiftUI

struct SeatsInfo: View {
    
    @StateObject private var viewModel = SeatsViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ForEach(viewModel.seats, id: \.self) { row in
                    HStack(spacing: 10) {
                        Text(row.first?.row ?? "")
                            .font(.caption)
                            .frame(width: 20) // row 텍스트의 고정된 너비
                        
                        HStack(spacing: 10) {
                            ForEach(Array(row.enumerated()), id: \.offset) { index, seat in
                                VStack {
                                    if seat.isSelected {
                                        Image("selectedseat")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .onTapGesture {
                                                viewModel.toggleSeatSelection(seat: seat)
                                            }
                                    } else if seat.isAvailable {
                                        Image("selectableseat")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .onTapGesture {
                                                viewModel.toggleSeatSelection(seat: seat)
                                            }
                                    } else {
                                        Image("impossibleseat")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                .frame(width: 20, height: 20)
                            }
                        }
                        .padding(10)
                        .background(colorForSection(row.first?.section ?? ""))
                        .cornerRadius(5)
                        
                        Text(row.first?.row ?? "")
                            .font(.caption)
                            .frame(width: 20) // row 텍스트의 고정된 너비
                    }
                }
            }
            .padding(.top, 30)
        }
    }
        
    func colorForSection(_ section: String) -> Color {
        switch section {
        case "SR":
            return Color.blue.opacity(0.2)
        case "R":
            return Color.green.opacity(0.2)
        case "S":
            return Color.red.opacity(0.2)
        default:
            return Color.gray.opacity(0.2)
        }
    }
}

#Preview{
    SeatsInfo()
}
