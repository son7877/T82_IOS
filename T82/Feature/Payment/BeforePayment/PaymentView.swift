import SwiftUI

struct PaymentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isPaymentComplete: Bool = false
    var selectedSeats: [SelectableSeat]
    
    var body: some View {
        CustomNavigationBar(
            isDisplayLeftBtn: true,
            isDisplayRightBtn: false,
            isDisplayTitle: true,
            leftBtnAction: {
                presentationMode.wrappedValue.dismiss()
            },
            rightBtnAction: {},
            lefttBtnType: .back,
            rightBtnType: .mylike,
            Title: "결제 내용"
        )
        .padding()
        .navigationBarBackButtonHidden()
        
        VStack{
            CouponList()
            Divider()
                .padding()
            PaymentSelection()
            PaymentPrice(selectedSeats: selectedSeats)
            TicketingProcessBtn(
                destination: PaymentCompleteView(),
                title: "결제하기"
            )
            .simultaneousGesture(TapGesture().onEnded {
                let urlString = "https://ul.toss.im?scheme=supertoss%3A%2F%2Fpay%3FpayToken%3DzwdAh0wG3ZZIw49kl3gB46"
                            
                if let url = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("오류")
                    }
                }
            })
        }
        
    }
}


