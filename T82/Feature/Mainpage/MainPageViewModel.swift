import Foundation

class MainPageViewModel: ObservableObject {
    
    // 현재 판매 중인 티켓 중 판매량 많은 순
    @Published var mainTicketTopRanking = [MainContents]()
    
    // 상위 카테고리 별 판매량 많은 순
    @Published var mainTicketCategoryRanking = [MainContents]()
    
    // 전체 공연 중 티켓 오픈이 다가오는 순
    @Published var mainTicketOpenSoon = [MainContents]()
    
    // 전체 공연 중 할인율이 높은 순
    @Published var mainTicketDiscountsRanking = [DiscountedContents]()
    
    
    // MARK: - 통신
    func fetchMainPageData() {
        fetchMainTicketTopRanking()
        fetchMainTicketCategoryRanking(for: .concert)
        fetchMainTicketOpenSoon()
        fetchMainTicketDiscounts()
    }
    
    // 현재 판매 중인 티켓 중 판매량 많은 순
    func fetchMainTicketTopRanking() {
        MainContentsService.shared.getMainEventsRank { [weak self] mainContents in
            guard let self = self else { return }
            if let mainContents = mainContents {
                self.mainTicketTopRanking = mainContents
            } else {
                // 오류 처리
                print("목록을 불러오지 못했습니다.")
            }
        }
    }
    
    // 상위 카테고리 별 판매량 많은 순 -> 카테고리 분류 생각
    // 상위 카테고리 1(콘서트) 2(뮤지컬) 3(스포츠)
    func fetchMainTicketCategoryRanking(for genre: Genre) {
        MainContentsService.shared.getMainEventsCategoryRank(category: genre.rawValue) { [weak self] mainContents in
            guard let self = self else { return }
            if let mainContents = mainContents {
                self.mainTicketCategoryRanking = mainContents
            } else {
                // 오류 처리
                print("목록을 불러오지 못했습니다.")
            }
        }
    }
    
    // 전체 공연 중 티켓 오픈이 다가오는 순
    func fetchMainTicketOpenSoon() {
        MainContentsService.shared.getMainEventsOpenSoon { [weak self] mainContents in
            guard let self = self else { return }
            if let mainContents = mainContents {
                self.mainTicketOpenSoon = mainContents
            } else {
                // 오류 처리
                print("목록을 불러오지 못했습니다.")
            }
        }
    }
    
    // 전체 공연 중 할인율이 높은 순 (1-2 task)
    func fetchMainTicketDiscounts() {
        mainTicketDiscountsRanking = [
            DiscountedContents(eventId: 1, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedContents(eventId: 2, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedContents(eventId: 3, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedContents(eventId: 4, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000),
            DiscountedContents(eventId: 5, title: "뮤지컬 레드북", rating: 4.5, discountRate: 0.2, discountedPrice: 20000)
        ]
    }
}
