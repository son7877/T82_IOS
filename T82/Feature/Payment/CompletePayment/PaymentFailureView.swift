import SwiftUI

struct PaymentFailureView: View {
    var body: some View {
        VStack{
            Text("결제 실패!")
            
            Spacer()
            
            TicketingProcessBtn(destination: MainView(), title: "홈으로")
        }
    }
}

#Preview {
    PaymentFailureView()
}
