import Foundation

class SubCategoryViewModel: ObservableObject {
    @Published var subCategoryEvents: [MainContents] = []
    @Published var openSoonEvents: [MainContents] = []
    let genre: Genre
    let subCategory: SubCategory

    init(genre: Genre, subCategory: SubCategory) {
        self.genre = genre
        self.subCategory = subCategory
        fetchSubCategoryEvents()
        fetchOpenSoonEvents()
    }

    func fetchSubCategoryEvents() {
        // 통신으로 대체
        self.subCategoryEvents = [
            MainContents(id: 1, title: "\(subCategory.name) Event 1", rating: 4.5),
            MainContents(id: 2, title: "\(subCategory.name) Event 2", rating: 3.5),
            MainContents(id: 3, title: "\(subCategory.name) Event 3", rating: 4.0)
        ]
    }

    func fetchOpenSoonEvents() {
        // 통신으로 대체
        self.openSoonEvents = [
            MainContents(id: 4, title: "\(subCategory.name) Open Soon Event 1", rating: 4.5),
            MainContents(id: 5, title: "\(subCategory.name) Open Soon Event 2", rating: 3.5),
            MainContents(id: 6, title: "\(subCategory.name) Open Soon Event 3", rating: 4.0)
        ]
    }
}
