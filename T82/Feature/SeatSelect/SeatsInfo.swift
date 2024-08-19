import SwiftUI

struct SeatsInfo: View {
    
    @ObservedObject var viewModel: SeatsViewModel
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(spacing: 20) {
                ForEach(viewModel.seats, id: \.self) { row in
                    HStack(spacing: 10) {
                        HStack(spacing: 10) {
                            ForEach(Array(row.enumerated()), id: \.element.id) { index, seat in
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
                        .background(colorForSection(row.first?.name ?? ""))
                        .cornerRadius(5)
                        
                    }
                }
            }
            .padding(.top, 30)
        }
        .alert(isPresented: $viewModel.showMaxSeatsAlert) {
            Alert(title: Text("최대 좌석 선택"), message: Text("최대 5개의 좌석만 선택할 수 있습니다."), dismissButton: .default(Text("확인")))
        }
    }
    
    func colorForSection(_ section: String) -> Color {
        switch section {
        case "VIP":
            return Color.blue.opacity(0.2)
        case "S석":
            return Color.green.opacity(0.2)
        case "A석":
            return Color.red.opacity(0.2)
        default:
            return Color.gray.opacity(0.2)
        }
    }
}
