import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var searchResults: [SearchContents] = []
    @Published var searchWord: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func searchResults(searchWord: String) {
        // 검색어가 비어있다면 API 호출을 하지 않도록 처리
        guard !searchWord.isEmpty else {
            self.searchResults = []
            self.errorMessage = "검색어를 입력해 주세요"
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        MainContentsService.shared.searchEventInfo(searchWord: searchWord) { [weak self] searchContents in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let searchContents = searchContents, !searchContents.isEmpty {
                    self?.searchResults = searchContents
                } else {
                    self?.searchResults = []
                    self?.errorMessage = "검색 결과가 없습니다."
                }
            }
        }
    }
}
