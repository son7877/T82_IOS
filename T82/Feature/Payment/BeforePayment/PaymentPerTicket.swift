import SwiftUI

struct PaymentPerTicket: View {
    
    var selectedSeats: [SelectableSeat]
    @State private var isShowDiscount: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.95, height: 300)
                    .cornerRadius(15)
                    .padding()
                
                ScrollView {
                    ForEach(selectedSeats, id: \.id) { seat in
                        VStack {
                            HStack {
                                Text("\(seat.name)  \(seat.rowNum)-\(seat.colNum)석")
                                    .font(.system(size: 20))
                                    .padding(.leading, 30)
                                Spacer()
                                Button(
                                    action: {
                                        isShowDiscount.toggle()
                                    },
                                    label: {
                                        Image("coupon")
                                    }
                                )
                                Spacer()
                                Text("\(seat.price)원")
                                    .font(.system(size: 20))
                                    .padding(.trailing, 30)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowDiscount) {
            // 쿠폰 리스트 뷰를 모달로 표시
            CouponListView()
        }
    }
}
