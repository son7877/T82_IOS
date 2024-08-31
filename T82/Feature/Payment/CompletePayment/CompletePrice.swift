import SwiftUI

struct CompletePrice: View {
    @EnvironmentObject var paymentViewModel: PaymentViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(Color.customGray0)
                    .frame(width: geometry.size.width * 0.9, height: 60)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                HStack {
                    Text("결제 가격")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.leading, 40)

                    Spacer()

                    Text("\(paymentViewModel.totalPrice) 원")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.customPink)
                        .padding(.trailing, 40)
                }
            }
        }
    }
}

