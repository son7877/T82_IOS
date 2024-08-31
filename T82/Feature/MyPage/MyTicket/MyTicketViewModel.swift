import Foundation
import Combine

class MyTicketViewModel: ObservableObject {
    
    @Published var MyTicketContents: [MyTicket] = []
    @Published var showModal = false
    @Published var selectedTicket: MyTicket? = nil
    @Published var ticketList: [Int: MyTicket] = [:]
    @Published var reviewAlert = false
    @Published var refundAlert = false
    @Published var isLoading = false
    @Published var isEmpty = false
    @Published var refundSuccess = false
    
    func fetchMyTicket() {
        guard !isLoading else { return } // 중복 호출 방지
        isLoading = true
        isEmpty = false
        
        TicketService.shared.getMyTickets() { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.MyTicketContents = response
                self.isEmpty = response.isEmpty
            case .failure(let error):
                print("티켓 불러오기 실패: \(error)")
            }
        }
        
        
    }
    
    func requestRefund(for ticket: MyTicket, reason: String, completion: @escaping (Bool, String) -> Void) {
        let refundRequest = Refund(orderNo: ticket.orderNum, seatId: ticket.seatId, amount: ticket.paymentAmount, reason: reason)
        PaymentService.shared.requestRefund(refundRequest: refundRequest) { [weak self] result in
            switch result {
            case .success:
                self?.refundSuccess = true
                self?.MyTicketContents.removeAll { $0.ticketId == ticket.ticketId }
                completion(true, "")
            case .failure(let error):
                self?.refundAlert = true
                completion(false, error.localizedDescription)
            }
        }
    }
}
