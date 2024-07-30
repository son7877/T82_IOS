import SwiftUI

struct PaymentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isPaymentComplete: Bool = false
    var selectedSeats: [SelectableSeat]
    var eventId: Int
    @StateObject private var couponViewModel = CouponListViewModel()
    @StateObject private var paymentViewModel = PaymentViewModel()
    @StateObject private var seatViewmodel = SeatsViewModel()

    var body: some View {
        
        VStack{
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {
                    presentationMode.wrappedValue.dismiss()
                    // 추후 선택된 선택 좌석을 초기화하는 로직 추가 필요
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
                destination: PaymentInProgressView(couponViewModel: couponViewModel, selectedSeats: selectedSeats, eventId: eventId)
                    .environmentObject(paymentViewModel),
                title: "결제하기"
            )
        }
        .navigationBarBackButtonHidden()
        .onAppear(){
            seatViewmodel.addPendingSeat(seats: selectedSeats.map {
                PendingSeat(
                    seatId: $0.seatId,
                    eventId: eventId,
                    price: $0.price
                ) })
        }
    }
}
