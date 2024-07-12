import SwiftUI

struct PaymentView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
        
        VStack{
            CouponList()
            Divider()
                .padding()
            PaymentSelection()
            PaymentPrice()
            TicketingProcessBtn(
                destination: PaymentCompleteView(),
                title: "결제하기"
            )
        }
    }
}

#Preview {
    PaymentView()
}
