//
//  TossPayment.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import SwiftUI
import TossPayments

private enum Constants {
    static let clientKey: String = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm"
    static let 테스트결제정보: PaymentInfo = DefaultPaymentInfo(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "싸이 흠뻑쇼",
        customerName: "안홍범"
    )
}

struct TossPaymentsView: View {
    
    @State private var showingSuccess: Bool = false
    @State private var showingFail: Bool = false
    @StateObject var viewModel = TossPaymentViewModel()
    
    var body: some View {
        
        VStack{
            ScrollView {
                VStack(spacing: 0) {
                    
                    PaymentMethodWidgetView(widget: viewModel.widget, amount: PaymentMethodWidget.Amount(value: 1000))
                    
                    AgreementWidgetView(widget: viewModel.widget)
                }
            }
            .padding()
            
            Button("결제하기") {
                viewModel.requestPayment(info: DefaultWidgetPaymentInfo(orderId: "9lD0azJWxjBY0KOIumGzH", orderName: "안홍범"))
            }
            .alert(isPresented: $showingSuccess, content: {
                Alert(title: Text(verbatim: "Success"), message: Text(verbatim: viewModel.onSuccess?.orderId ?? ""))
            })
            .alert(isPresented: $showingFail, content: {
                Alert(title: Text(verbatim: "Fail"), message: Text(verbatim: viewModel.onFail?.orderId ?? ""))
            })
            .onReceive(viewModel.$onSuccess.compactMap { $0 }) { success in
                showingSuccess = true
            }
            .onReceive(viewModel.$onFail.compactMap { $0 }) { fail in
                showingFail = true
            }.padding()
        }
    }
}

#Preview {
    TossPaymentsView()
}

