import SwiftUI

struct PaymentPrice: View{
    
    // 예시
    @State private var selectedSection: Sections = Sections(sectionId: 1, name: "R석", totalSeat: 200, restSeat: 20, price: 200000, eventId: 1)
    
    // 예시
    @State private var couponList: [Coupons] = [
        Coupons(couponName: "첫 회원 가입 기념 쿠폰", discountType: 0.2, discountValue: 0),
        Coupons(couponName: "7월 기념 쿠폰", discountType: 0.1, discountValue: 0)
    ]
    
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.customgray0)
                .frame(width: 340, height: 50)
                .cornerRadius(15)
                .padding()
            
            HStack{
                Text("할인 가격").padding(50)
                Spacer()
                Text("- \(Int(Double(selectedSection.price) * couponList[0].discountType)) 원")
                    .padding(.horizontal, 50)
                    .foregroundColor(.customPink)
            }
        }
        
        ZStack{
            Rectangle()
                .foregroundColor(.customgray0)
                .frame(width: 340, height: 50)
                .cornerRadius(15)
                .padding()
            
            HStack{
                Text("결제 금액").padding(50)
                Spacer()
                Text("\(selectedSection.price - Int(Double(selectedSection.price) * couponList[0].discountType)) 원")
                    .padding(50)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.customPink)
            }
        }
    }
}
