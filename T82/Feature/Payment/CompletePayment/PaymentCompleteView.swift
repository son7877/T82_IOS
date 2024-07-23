import SwiftUI

struct PaymentCompleteView: View {
    var body: some View {
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
        .navigationBarBackButtonHidden()
        
        VStack {
            CompleteTicket()
            CompletePrice()
            
            HStack{
                Button(
                    action: {},
                    label: {
                        Text("내 예매 내역으로 이동")
                            .font(.system(size: 20))
                            .foregroundColor(.customgray1)
                    }
                )
            }
            
            
        }
        // 합칠 때 MainView로 변경
        TicketingProcessBtn(destination: MainView(), title: "홈으로")
    }
}

#Preview {
    PaymentCompleteView()
}
