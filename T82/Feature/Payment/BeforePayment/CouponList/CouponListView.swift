import SwiftUI

struct CouponListView: View {
    @StateObject private var viewModel = CouponListViewModel()
    var onCouponSelected: (Coupon) -> Void
    var selectedCouponId: String?
    var usedCoupons: Set<String>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.coupons, id: \.couponId) { coupon in
                        CouponRowView(
                            coupon: coupon,
                            onCouponSelected: onCouponSelected,
                            isSelected: selectedCouponId == coupon.couponId,
                            isUsed: usedCoupons.contains(coupon.couponId)
                        )
                    }
                }
                .padding()
                .navigationTitle("쿠폰 목록")
                .onAppear {
                    viewModel.fetchCoupons()
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
        VStack(alignment: .leading, spacing: 12) {
            Text(coupon.couponName)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("할인: \(discountAmount())")
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Text("유효기간: \(formattedDay)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: {
                if isSelected {
                    onCouponSelected(
                        Coupon(couponId: "", couponName: "", discountType: "", discountValue: 0, validEnd: "", minPurchase: 0, duplicate: false, category: "")
                    )
                } else {
                    onCouponSelected(coupon)
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(isSelected ? "적용중" : (isUsed ? "사용중" : "적용"))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(isSelected ? Color.gray : (isUsed ? Color.gray : Color.customred))
                    .cornerRadius(8)
                    .font(.subheadline)
            }
            .disabled(isUsed && !isSelected)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.customgray0 : Color.clear, lineWidth: 2)
        )
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
