import SwiftUI

struct SeatsPrice: View {
    
    @StateObject private var seatsViewModel = SeatsViewModel()
    
    var body: some View {
        ZStack{
            Image("myTicket")
                .resizable()
                .frame(width: 350, height: 250)
                .rotationEffect(.degrees(180))
                .shadow(radius: 3, x: 5, y: 5)
        }
    }
}

#Preview {
    SeatsPrice()
}
