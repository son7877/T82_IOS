import SwiftUI

struct FirstEventCouponView: View {
    @State private var buttonStates = [Bool](repeating: false, count: 3)
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    // 통신으로 받아온 쿠폰 이벤트 리스트
                    
                    ForEach(0..<1) { index in
                        ZStack{
                            Rectangle()
                                .frame(height: 120)
                                .foregroundColor(.customgray0)
                            HStack{
                                VStack(alignment: .leading) {
                                    HStack{
                                        // 카테고리
                                        Text("ALL")
                                            .font(.subheadline)
                                            .fontWeight(.heavy)
                                        Text("이벤트 쿠폰명")
                                            .font(.subheadline)
                                   }
                                    .padding(.bottom, 1)
                                    
                                    Text("이벤트 쿠폰 금액")
                                        .font(.title2)
                                        .padding(.bottom,3)
                                    HStack{
                                        Text("유효기간 / 최소 결제 금액")
                                            .font(.subheadline)
                                    }
                                }
                                .padding()
                                Spacer()
                                Button(action: {
                                    // 쿠폰 발급 통신
                                    buttonStates[index] = true
                                }, label: {
                                    Text(buttonStates[index] ? "받기 완료" : "받기")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 100)
                                        .background(buttonStates[index] ? Color.gray : Color.customred)
                                        .cornerRadius(10)
                                })
                                .padding()
                                .disabled(buttonStates[index]) 
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
    }
}

