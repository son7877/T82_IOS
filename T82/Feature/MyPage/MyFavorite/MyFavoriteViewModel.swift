import Foundation

class MyFavoriteViewModel: ObservableObject{
    
    @Published var favoriteList: [MyFavorites] = []
    @Published var isLoading = false
    
    // MARK: - 내 공연 관심 목록 조회
    func fetchMyFavorites(){
        isLoading = true
        MainContentsService.shared.getMyInterestEvents { [weak self] myFavorites in
            guard let self = self else { return }
            if let myFavorites = myFavorites {
                self.favoriteList = myFavorites
                self.isLoading = false
            } else {
                print("찜 목록 조회 실패")
                self.isLoading = false
            }
        }
    }
}
