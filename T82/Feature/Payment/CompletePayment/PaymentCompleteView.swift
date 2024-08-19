import SwiftUI

struct PaymentCompleteView: View {
    
    @EnvironmentObject var paymentViewModel: PaymentViewModel
    @ObservedObject var viewModel: MyTicketViewModel

    var body: some View {
        VStack {
            CustomNavigationBar(
                isDisplayLeftBtn: false,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {},
                rightBtnAction: {},
                lefttBtnType: .back,
                rightBtnType: .mylike,
                Title: "결제 완료"
            )
            .padding()
            .navigationBarBackButtonHidden(true)

            VStack {
                CompletePrice()
                    .environmentObject(paymentViewModel)
            }
            TicketingProcessBtn(destination: MainView(selectedIndex: 0), title: "예매 내역 이동")
        }
        .onDisappear(){
            viewModel.fetchMyTicket()
        }
    }
}
