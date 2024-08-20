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
                isDisplayLeftBtn: false,
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
            
            // 결재 할 티켓
            PaymentPerTicket(selectedSeats: selectedSeats)
                .environmentObject(couponViewModel)
            
            // 결제 수단 선택 (추후 Click 결제 추가)
            PaymentSelection()
            
            // 결제금액
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
                )
            })
        }
        .alert(isPresented: $seatViewmodel.showAlert) {
            Alert(
                title: Text("좌석 선택 실패"),
                message: Text(seatViewmodel.alertMessage),
                dismissButton: .default(Text("확인")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
