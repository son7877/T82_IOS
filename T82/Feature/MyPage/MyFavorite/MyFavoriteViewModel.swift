import Foundation
import SwiftUI

class MyFavoriteViewModel: ObservableObject {
    
    @Published var favoriteList: [MainContents] = []
    @Published var isLoading = false
    @AppStorage("userID") private var userID: String = "defaultUserID"

    // MARK: - 내 공연 관심 목록 조회
    func fetchMyFavorites() {
        isLoading = true
        MainContentsService.shared.getMainEventsOpenSoon { [weak self] myFavorites in
            guard let self = self else { return }
            if let myFavorites = myFavorites {
                self.favoriteList = myFavorites.filter {
                    let interestKey = "interest_\(self.userID)_\($0.id)"
                    let isInterested = UserDefaults.standard.bool(forKey: interestKey)
                    return isInterested
                }
                self.isLoading = false
            } else {
                self.isLoading = false
            }
        }
    }
}
