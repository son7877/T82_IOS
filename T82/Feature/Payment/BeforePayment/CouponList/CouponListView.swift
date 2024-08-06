import SwiftUI

struct CouponListView: View {
    @StateObject private var viewModel = CouponListViewModel()
    var onCouponSelected: (Coupon) -> Void
    var selectedCouponId: String?
    var usedCoupons: Set<String>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(viewModel.coupons, id: \.couponId) { coupon in
                        CouponRowView(coupon: coupon, onCouponSelected: onCouponSelected, isSelected: selectedCouponId == coupon.couponId, isUsed: usedCoupons.contains(coupon.couponId))
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
    var onCouponSelected: (Coupon) -> Void
    var isSelected: Bool
    var isUsed: Bool

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
                if isSelected {
                    onCouponSelected(
                        Coupon(couponId: "", couponName: "", discountType: "", discountValue: 0, validEnd: "", minPurchase: 0, duplicate: false, category: "")
                    )
                } else {
                    onCouponSelected(coupon)
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(isSelected ? "적용중" : (isUsed ? "사용중" : "적용"))
                    .foregroundColor(.white)
                    .background(isSelected ? Color.gray : (isUsed ? Color.gray : Color.red))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .cornerRadius(10)
            }
            .disabled(isUsed && !isSelected)
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
