import SwiftUI

struct CouponListView: View {
    @StateObject private var viewModel = CouponListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(viewModel.coupons, id: \.couponId) { coupon in
                        CouponRowView(coupon: coupon)
                            .padding(.vertical, 20)
                    }
                }
                .navigationTitle("쿠폰 목록")
                .onAppear {
                    viewModel.fetchCoupons(page: 0, size: 5)
                }
            }
        }
    }
}

struct CouponRowView: View {
    let coupon: Coupon
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Text(coupon.couponName)
                .font(.headline)
                .padding(.bottom, 10)
            Text("할인: \(discountAmount())")
                .font(.subheadline)
                .padding(.bottom, 10)
            Text("유효기간: \(formattedDay)")
                .font(.subheadline)
                .padding(.bottom, 10)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("적용")
                    .foregroundColor(.white)
                    .background(.customRed)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .cornerRadius(10)
            }
        }
    }
    
    private func discountAmount() -> String {
        switch coupon.discountType {
        case "PERCENTAGE":
            return "\(coupon.discountValue)%"
        case "FIXED":
            return "-\(coupon.discountValue)원"
        default:
            return ""
        }
    }
    
    private var formattedDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: coupon.validEnd) ?? Date()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
}

