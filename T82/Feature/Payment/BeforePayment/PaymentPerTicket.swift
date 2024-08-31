import SwiftUI

struct PaymentPerTicket: View {
    
    @State var selectedSeats: [SelectableSeat]
    @State private var currentSeatIndex: Int? = nil
    @EnvironmentObject var couponViewModel: CouponListViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.95, height: 300)
                    .cornerRadius(15)
                    .padding()
                
                ScrollView {
                    ForEach(selectedSeats.indices, id: \.self) { index in
                        let seat = selectedSeats[index]
                        let finalPrice = calculateFinalPrice(for: seat, with: couponViewModel.couponList[seat.id])
                        VStack {
                            HStack {
                                Text("\(seat.name)  \(seat.rowNum)-\(seat.colNum)석")
                                    .font(.system(size: 20))
                                    .padding(.leading, 30)
                                Spacer()
                                Button(
                                    action: {
                                        currentSeatIndex = index
                                        couponViewModel.isShowDiscount = true
                                    },
                                    label: {
                                        Image("coupon")
                                    }
                                )
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("\(seat.price) 원")
                                        .font(.system(size: 20))
                                    if let coupon = couponViewModel.couponList[seat.id],
                                       let discountAmount = PaymentPerTicket.calculateDiscount(for: seat.price, with: coupon) {
                                        Text("할인 적용: -\(discountAmount) 원")
                                            .font(.system(size: 16))
                                            .foregroundColor(.customorange)
                                    }
                                }
                                .padding(.trailing, 30)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $couponViewModel.isShowDiscount) {
            if let seatIndex = currentSeatIndex {
                CouponListView(onCouponSelected: { coupon in
                    if let currentCoupon = couponViewModel.couponList[selectedSeats[seatIndex].id] {
                        couponViewModel.usedCoupons.remove(currentCoupon.couponId)
                    }
                    couponViewModel.couponList[selectedSeats[seatIndex].id] = coupon
                    couponViewModel.usedCoupons.insert(coupon.couponId)
                    couponViewModel.isShowDiscount = false
                }, selectedCouponId: couponViewModel.couponList[selectedSeats[seatIndex].id]?.couponId, usedCoupons: couponViewModel.usedCoupons)
            }
        }
    }
    
    // 할인 금액 계산
    static func calculateDiscount(for price: Int, with coupon: Coupon) -> Int? {
        switch coupon.discountType {
        case "PERCENTAGE":
            return price * coupon.discountValue / 100
        case "FIXED":
            return coupon.discountValue
        default:
            return nil
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
