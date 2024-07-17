//
//  TossPaymentContentViewModel.swift
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

class TossPaymentViewModel: ObservableObject {
    let widget = PaymentWidget(clientKey: Constants.clientKey, customerKey: "Test")

    @Published
    var isShowing: Bool = false
    @Published
    var onSuccess: TossPaymentsResult.Success?
    @Published
    var onFail: TossPaymentsResult.Fail?
    
    init() {
        widget.delegate = self
    }
    func requestPayment(info: WidgetPaymentInfo) {
        widget.requestPayment(
            info: DefaultWidgetPaymentInfo(orderId: "9lD0azJWxjBY0KOIumGzH", orderName: "안홍범")
        )
    }
}
                              
extension TossPaymentViewModel: TossPaymentsDelegate {
    func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        onSuccess = success
    }
    
    func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        onFail = fail
    }
}
