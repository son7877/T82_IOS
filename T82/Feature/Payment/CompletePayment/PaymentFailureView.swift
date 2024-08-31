import SwiftUI

struct PaymentFailureView: View {
    var body: some View {
        VStack{
            Text("결제 실패!")
            
            Spacer()
            
            TicketingProcessBtn(destination: MainView(selectedIndex: 4), title: "홈으로")
        }
    }
}

#Preview {
    PaymentFailureView()
}
