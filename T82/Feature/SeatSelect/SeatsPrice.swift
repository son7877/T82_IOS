import SwiftUI

struct SeatsPrice: View {
    
    @ObservedObject var seatsViewModel: SeatsViewModel
    
    var body: some View {
        ZStack {
            ticketImageView
            ScrollView{
                selectedSeatsInfoView
            }
        }
        .frame(width: 350, height: 250)
    }
    
    var ticketImageView: some View {
        Rectangle()
            .frame(width: 350, height: 250)
            .foregroundColor(.white)
            .shadow(radius: 3, x: 5, y: 5)
    }
    
    var selectedSeatsInfoView: some View {
        VStack {
            ForEach(seatsViewModel.selectedSeats) { seat in
                seatInfoRow(seat: seat)
            }
        }
        .padding()
    }
    
    func seatInfoRow(seat: SelectableSeat) -> some View {
        HStack {
            Text("좌석: \(seat.rowNum) - \(seat.colNum)")
            Spacer()
            Text("\(seat.name)")
            Spacer()
            Text("가격: \(seat.price) 원")
        }
        .padding(.vertical,5)
    }
}

#Preview {
    SeatsPrice(seatsViewModel: SeatsViewModel())
}
