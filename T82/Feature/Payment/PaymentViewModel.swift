import SwiftUI

class PaymentViewModel: ObservableObject {
    
    @Published var totalPrice: Int = 0
    @Published var paymentURL: URL?
    @Published var paymentStatus: PaymentStatus = .pending

    enum PaymentStatus {
        case pending
        case success
        case failure
    }
}
