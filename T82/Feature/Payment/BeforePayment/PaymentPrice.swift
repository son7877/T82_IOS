import SwiftUI

struct PaymentPrice: View {
    
    var selectedSeats: [SelectableSeat]
    
    // 예시
    @State private var couponList: [Coupons] = [
        Coupons(couponName: "첫 회원 가입 기념 쿠폰", discountType: 0.2, discountValue: 0),
        Coupons(couponName: "7월 기념 쿠폰", discountType: 0.1, discountValue: 0)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.customgray0)
                    .frame(width: geometry.size.width * 0.95, height: 150)
                    .cornerRadius(15)
                
                VStack {
                    HStack {
                        Text("판매 가격")
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
        .frame(height: 200) // GeometryReader의 높이 설정
    }
    
    private func totalPrice() -> Int {
        return selectedSeats.map { $0.price }.reduce(0, +)
    }
    
    private func discountAmount() -> Int {
        let discount = couponList[0].discountType
        return Int(Double(totalPrice()) * discount)
    }
}
