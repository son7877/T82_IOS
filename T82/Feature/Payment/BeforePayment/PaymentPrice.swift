import SwiftUI

struct PaymentPrice: View {
    
    var selectedSeats: [SelectableSeat]
    var selectedCoupons: [Int: Coupon] // 좌석 ID별로 적용된 쿠폰
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.customgray0)
                    .frame(width: geometry.size.width * 0.95, height: 150)
                    .cornerRadius(15)
                    .padding()
                
                VStack {
                    HStack {
                        Text("총 가격")
                            .padding(.leading, 50)
                            .font(.system(size: 20))
                        Spacer()
                        Text(" \(totalPrice()) 원")
                            .padding(.horizontal, 50)
                            .font(.system(size: 20))
                            .foregroundColor(.customPink)
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("할인 가격")
                            .padding(.leading, 50)
                            .font(.system(size: 20))
                        Spacer()
                        Text("- \(discountAmount()) 원")
                            .padding(.horizontal, 50)
                            .font(.system(size: 20))
                            .foregroundColor(.customPink)
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        Text("결제 금액")
                            .padding(.leading, 50)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        Text("\(totalPrice() - discountAmount()) 원")
                            .padding(.trailing, 50)
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(.customPink)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding(.vertical, 20)
        }
        .frame(height: 200)
    }
    
    private func totalPrice() -> Int {
        return selectedSeats.map { $0.price }.reduce(0, +)
    }
    
    private func discountAmount() -> Int {
        return selectedSeats.reduce(0) { result, seat in
            if let coupon = selectedCoupons[seat.id] {
                return result + PaymentPerTicket.calculateDiscount(for: seat.price, with: coupon)!
            } else {
                return result
            }
        }
    }
}
