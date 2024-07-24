import SwiftUI

struct PaymentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isPaymentComplete: Bool = false
    var selectedSeats: [SelectableSeat]
    @StateObject private var couponViewModel = CouponListViewModel() // 쿠폰 정보 관리

    var body: some View {
        
        VStack{
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
            
            Spacer()
            
            PaymentPerTicket(selectedSeats: selectedSeats)
                .environmentObject(couponViewModel)
            PaymentSelection()
            PaymentPrice(selectedSeats: selectedSeats, selectedCoupons: couponViewModel.couponList)
            TicketingProcessBtn(
                destination: PaymentCompleteView(),
                title: "결제하기"
            )
        }
        .navigationBarBackButtonHidden()
    }
}
