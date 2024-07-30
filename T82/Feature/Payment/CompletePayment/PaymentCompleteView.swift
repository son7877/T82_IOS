import SwiftUI

struct PaymentCompleteView: View {
    
    @EnvironmentObject var paymentViewModel: PaymentViewModel

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
                CompleteTicket()
                CompletePrice()
                    .environmentObject(paymentViewModel)

                HStack {
                    Button(
                        action: {
                            // 내 예매 내역으로 이동하는 액션
                        },
                        label: {
                            Text("내 예매 내역으로 이동")
                                .font(.system(size: 20))
                                .foregroundColor(.customgray1)
                        }
                    )
                }
            }

            Spacer()

            TicketingProcessBtn(destination: MainView(), title: "홈으로")
        }
    }
}
