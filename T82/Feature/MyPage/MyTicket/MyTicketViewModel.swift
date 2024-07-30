import Foundation
import Combine

class MyTicketViewModel: ObservableObject {
    
    @Published var MyTicketContents: [MyTicket] = []
    @Published var showModal = false
    @Published var selectedTicket: MyTicket? = nil
    @Published var ticketList: [Int: MyTicket] = [:]
    @Published var reviewAlert = false
    @Published var isLoading = false
    @Published var isEmpty = false
    
    var currentPage = 0
    private var totalPages = 0
    
    init() {
        fetchMyTicket(page: currentPage, size: 5)
    }
    
    func fetchMyTicket(page: Int, size: Int) {
        guard !showModal else { return }
        
        isLoading = true
        isEmpty = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            TicketService.shared.getMyTickets(page: page, size: size) { result in
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
    }
}
