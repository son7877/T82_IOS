import SwiftUI
import FirebaseMessaging

struct PaymentInProgressView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var paymentViewModel: PaymentViewModel
    @ObservedObject var couponViewModel: CouponListViewModel
    @State private var navigateToCompleteView = false
    var selectedSeats: [SelectableSeat]
    var eventId: Int

    var body: some View {
        VStack {
            Image("Logo")
                .padding(.bottom, 50)
            Text("결제 진행중...")
                .font(.system(size: 20))
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding(.top, 20)
            
            NavigationLink(
                destination: PaymentCompleteView(viewModel: MyTicketViewModel())
                    .environmentObject(paymentViewModel),
                isActive: $navigateToCompleteView
            ) {
                EmptyView()
            }
        }
        .onAppear {
            makePayment()
        }
        .navigationBarBackButtonHidden(true)
    }

    func makePayment() {
        let items = selectedSeats.map { seat in
            let couponIds = couponViewModel.couponList[seat.id]?.couponId != nil ? [couponViewModel.couponList[seat.id]!.couponId] : []
            let finalPrice = calculateFinalPrice(for: seat, with: couponViewModel.couponList[seat.id])
            return PaymentItem(
                seatId: seat.seatId,
                couponIds: couponIds,
                beforeAmount: seat.price,
                amount: finalPrice
            )
        }

        let paymentRequest = PaymentRequest(
            totalAmount: items.reduce(0) { $0 + $1.amount },
            eventId: eventId,
            items: items
        )

        // 토스 결제 API 호출
        PaymentService.shared.tossPayment(paymentRequest: paymentRequest) { result in
            switch result {
            case .success(let paymentResponse):
                if let urlString = paymentResponse.paymentURL, let url = URL(string: urlString) {
                    print("Valid payment URL received: \(urlString)")
                    DispatchQueue.main.async {
                        paymentViewModel.totalPrice = paymentRequest.totalAmount
                        paymentViewModel.paymentURL = url
                        openURL(url)
                    }
                } else {
                    print("Invalid payment URL")
                    DispatchQueue.main.async {
                        paymentViewModel.paymentStatus = .failure
                    }
                }
            case .failure(let error):
                print("Payment request failed with error: \(error)")
                DispatchQueue.main.async {
                    paymentViewModel.paymentStatus = .failure
                }
            }
        }
    }

    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        paymentViewModel.paymentStatus = .success
                        navigateToCompleteView = true
                    }
                } else {
                    print("오류: URL을 열 수 없습니다.")
                }
            })
        } else {
            print("오류: URL을 열 수 없습니다.")
        }
    }

    // 최종 가격 계산
    func calculateFinalPrice(for seat: SelectableSeat, with coupon: Coupon?) -> Int {
        if let coupon = coupon, let discountAmount = PaymentPerTicket.calculateDiscount(for: seat.price, with: coupon) {
            return seat.price - discountAmount
        } else {
            return seat.price
        }
    }
}
