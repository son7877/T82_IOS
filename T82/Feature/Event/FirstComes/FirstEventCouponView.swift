import SwiftUI

struct FirstEventCouponView: View {
    
    @StateObject var firstEventCouponviewModel = FirstEventCouponViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @AppStorage("issuedCoupons") private var issuedCouponsData: Data = Data()
    @State private var issuedCoupons: [String: Bool?] = [:] // 쿠폰 발급 상태 관리
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(firstEventCouponviewModel.couponEvent) { couponEvent in
                    ZStack{
                        Rectangle()
                            .frame(height: 120)
                            .foregroundColor(.customgray0)
                        HStack{
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(couponEvent.category)
                                        .font(.subheadline)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.customred)
                                    Text(couponEvent.couponName)
                                        .font(.subheadline)
                               }
                                .padding(.bottom, 1)
                                
                                Text("\(couponEvent.discountValue)\(discountAmount(couponEvent.discountType)) 할인")
                                    .font(.title2)
                                    .padding(.bottom,3)
                                HStack{
                                    Text("\(dateFormatting(date: couponEvent.validEnd)) 까지 / \(couponEvent.minPurchase)원 이상 결제 시")
                                        .font(.subheadline)
                                }
                            }
                            .padding()
                            
                            Spacer()
                            
                            Button(action: {
                                firstEventCouponviewModel.issueEventCoupon(couponId: couponEvent.couponId) { success in
                                    if success {
                                        alertMessage = "이벤트 쿠폰 발급 성공"
                                        issuedCoupons[couponEvent.couponId] = true
                                    } else {
                                        alertMessage = "이미 마감되었습니다."
                                        issuedCoupons[couponEvent.couponId] = false
                                    }
                                    saveIssuedCoupons()
                                    showAlert = true
                                }
                            }) {
                                Text(buttonText(for: couponEvent.couponId))
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(buttonBackgroundColor(for: couponEvent.couponId))
                                    .cornerRadius(10)
                            }
                            .disabled(issuedCoupons[couponEvent.couponId] != nil) // 발급 상태가 있으면 버튼 비활성화
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear(){
            loadIssuedCoupons()
            firstEventCouponviewModel.fetchCouponEvent()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
    
    private func discountAmount(_ discountType: String) -> String {
        switch discountType {
        case "PERCENTAGE":
            return "%"
        case "FIXED":
            return "원"
        default:
            return ""
        }
    }
    
    private func buttonText(for couponId: String) -> String {
        if let status = issuedCoupons[couponId] {
            return status == true ? "발급 완료" : "마감"
        } else {
            return "받기"
        }
    }
    
    private func buttonBackgroundColor(for couponId: String) -> Color {
        if let status = issuedCoupons[couponId] {
            return status == true ? Color.gray : Color.red
        } else {
            return Color.customred
        }
    }
    
    private func dateFormatting(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date!)
    }
    
    private func saveIssuedCoupons() {
        issuedCouponsData = (try? JSONEncoder().encode(issuedCoupons)) ?? Data()
    }
    
    private func loadIssuedCoupons() {
        issuedCoupons = (try? JSONDecoder().decode([String: Bool?].self, from: issuedCouponsData)) ?? [:]
    }
}
