//
//  CouponList.swift
//  T82
//
//  Created by 안홍범 on 7/11/24.
//

import SwiftUI

struct CouponList: View {
    // 예시
    @State private var selectedSection: Sections = Sections(sectionId: 1, name: "R석", totalSeat: 200, restSeat: 20, price: 2000000, eventId: 1)
    
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
                Text("쿠폰 목록")
                Image("coupon")
                
                Button(
                    action: {
                    // 쿠폰 등록 모달 창 띄우기
                },
                    label: {
                    Image("back")
                        .rotationEffect(.degrees(180))
                })
                .padding(.leading, 180)
            }
            
        }
        
        // 쿠폰 예시
        ScrollView{
            HStack{
                Text("\(couponList[0].couponName)")
                Text("\(Int(couponList[0].discountType * 100))%")
                Button(
                    action: {
                        // 쿠폰 적용
                    },
                    label: {
                        Text("적용")
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                    })
                .background(.customPink)
                .cornerRadius(10)
            }
            Divider()
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .foregroundColor(.customgray1)
        }
    }
}
