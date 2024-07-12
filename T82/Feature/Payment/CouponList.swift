import SwiftUI

struct CouponList: View {
    
    // 예시
    @State private var selectedSection: Sections = Sections(sectionId: 1, name: "R석", totalSeat: 200, restSeat: 20, price: 2000000, eventId: 1)
    
    // 예시
    @State private var couponList: [Coupons] = [
        Coupons(couponName: "첫 회원 가입 기념 쿠폰", discountType: 0.2, discountValue: 0),
        Coupons(couponName: "7월 기념 쿠폰", discountType: 0.1, discountValue: 0)
    ]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .foregroundColor(.customgray0)
                        .frame(width: geometry.size.width * 0.95, height: 50)
                        .cornerRadius(15)
                        .padding()
                    
                    HStack {
                        Text("쿠폰 목록")
                            .padding(.leading, 30)
                        Image("coupon")
                        
                        Spacer()
                        
                        Button(
                            action: {
                                // 쿠폰 등록 모달 창 띄우기
                            },
                            label: {
                                Image("back")
                                    .rotationEffect(.degrees(180))
                            })
                            .padding(.trailing, 30)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(height: 80) // GeometryReader의 높이 설정
            
            // 쿠폰 리스트
            ScrollView {
                ForEach(couponList, id: \.couponName) { coupon in
                    VStack {
                        HStack {
                            Text(coupon.couponName)
                                .padding(.leading, 20)
                            Spacer()
                            Text("\(Int(coupon.discountType * 100))%")
                                .padding(.trailing, 20)
                            
                            Button(
                                action: {
                                    // 적용중인 쿠폰 변경
                                },
                                label: {
                                    Text("적용")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                })
                                .background(Color.customPink)
                                .cornerRadius(10)
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 40)
                        
                        Divider()
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.customgray1)
                    }
                }
            }
        }
    }
}
