import Foundation

class MainPageViewModel: ObservableObject {
    
    // 현재 판매 중인 티켓 중 판매량 많은 순
    @Published var mainTicketTopRanking = [MainEvents]()
    
    // 상위 카테고리 별 판매량 많은 순
    @Published var mainTicketCategoryRanking = [MainEvents]()
    
    // 전체 공연 중 티켓 오픈이 다가오는 순
    @Published var mainTicketOpenSoon = [MainEvents]()
    
    // 전체 공연 중 할인율이 높은 순
    @Published var mainTicketDiscountsRanking = [DiscountedEvents]()
    
    
    // MARK: - 통신
    func fetchMainPageData() {
        fetchMainTicketTopRanking()
        fetchMainTicketCategoryRanking()
        fetchMainTicketOpenSoon()
        fetchMainTicketDiscounts()
    }
    
    // 현재 판매 중인 티켓 중 판매량 많은 순
    func fetchMainTicketTopRanking() {
        MainEventService.shared.getMainEventsRank { [weak self] mainEvents in
            guard let self = self else { return }
            if let mainEvents = mainEvents {
                self.mainTicketTopRanking = mainEvents
            } else {
                // 오류 처리
                print("목록을 불러오지 못했습니다.")
            }
        }
    }
    
    // 상위 카테고리 별 판매량 많은 순 -> 카테고리 분류 생각
    func fetchMainTicketCategoryRanking() {
        mainTicketCategoryRanking = [
            MainEvents(id: 1, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 2, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 3, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 4, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 5, title: "뮤지컬 레드북", rating: 4.5)
        ]
    }
    
    // 전체 공연 중 티켓 오픈이 다가오는 순
    func fetchMainTicketOpenSoon() {
        mainTicketOpenSoon = [
            MainEvents(id: 1, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 2, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 3, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 4, title: "뮤지컬 레드북", rating: 4.5),
            MainEvents(id: 5, title: "뮤지컬 레드북", rating: 4.5)
        ]
    }
    
    // 전체 공연 중 할인율이 높은 순
    func fetchMainTicketDiscounts() {
        mainTicketDiscountsRanking = [
            DiscountedEvents(eventId: 1, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedEvents(eventId: 2, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedEvents(eventId: 3, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedEvents(eventId: 4, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedEvents(eventId: 5, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000)
        ]
    }
}
