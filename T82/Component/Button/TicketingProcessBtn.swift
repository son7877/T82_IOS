import SwiftUI

struct TicketingProcessBtn<Destination: View>: View {
    let destination: Destination
    let title: String

    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                ZStack {
                    Image("bottombar")
                        .resizable()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                    
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        )
    }
}
