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
    
    var currentPage = 0
    var totalPages = 5
    
    init() {
        fetchMyTicket(page: currentPage, size: 5)
    }
    
    // 내 티켓 정보 가져오기
    func fetchMyTicket(page: Int, size: Int) {
        guard !showModal else { return }
        
        isLoading = true
        isEmpty = false
        
        TicketService.shared.getMyTickets(page: page, size: size) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                if response.content.isEmpty {
                    self.isEmpty = true
                } else {
                    self.MyTicketContents.append(contentsOf: response.content)
                    self.totalPages = response.totalPages
                    self.currentPage = response.number
                }
            case .failure:
                self.isEmpty = true
            }
        }
    }
    
    // 다음 페이지의 티켓을 로드할지 결정
    func loadMoreTicketsIfNeeded(currentTicket: MyTicket) {
        guard currentPage < totalPages - 1 else { return } // 마지막 페이지인지 확인
        guard currentTicket == MyTicketContents.last else { return } // 마지막 티켓인지 확인
        
        currentPage += 1
        fetchMyTicket(page: currentPage, size: 5)
    }
    
    // 환불 요청
    func requestRefund(for ticket: MyTicket, reason: String, completion: @escaping (Bool, String) -> Void) {
        let refundRequest = Refund(orderNo: ticket.orderNum, seatId: ticket.seatId, amount: ticket.paymentAmount, reason: reason)
        PaymentService.shared.requestRefund(refundRequest: refundRequest) { [weak self] result in
            switch result {
            case .success:
                self?.refundSuccess = true
                // 환불 성공 후 티켓 목록에서 해당 티켓 삭제
                self?.MyTicketContents.removeAll { $0.ticketId == ticket.ticketId }
                completion(true, "")
            case .failure(let error):
                self?.refundAlert = true
                print("Failed to request refund: \(error.localizedDescription)")
                completion(false, error.localizedDescription)
            }
        }
    }
}
