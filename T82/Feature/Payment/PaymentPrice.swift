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
                .frame(width: 340, height: 150)
                .cornerRadius(15)
                .padding()
            
            VStack{
                HStack{
                    Text("판매 가격")
                        .padding(.leading ,50)
                        .font(.system(size: 20))
                    Spacer()
                    Text(" \(selectedSection.price) 원")
                        .padding(.horizontal, 50)
                        .font(.system(size: 20))
                        .foregroundColor(.customPink)
                }
                
                .padding(.vertical,5)
                HStack{
                    Text("할인 가격")
                        .padding(.leading ,50)
                        .font(.system(size: 20))
                    Spacer()
                    Text("- \(Int(Double(selectedSection.price) * couponList[0].discountType)) 원")
                        .padding(.horizontal, 50)
                        .font(.system(size: 20))
                        .foregroundColor(.customPink)
                }
                .padding(.vertical,5)
                
                HStack{
                    Text("결제 금액")
                        .padding(.leading ,50)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Text("\(selectedSection.price - Int(Double(selectedSection.price) * couponList[0].discountType)) 원")
                        .padding(.trailing,50)
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(.customPink)
                }
                .padding(.vertical,5)
            }
        }
        .padding(.vertical, 20)
    }
}
