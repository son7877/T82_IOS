import Foundation

class SubCategoryViewModel: ObservableObject {
    @Published var subCategoryEvents: [MainContents] = []
    @Published var openSoonEvents: [MainContents] = []
    let genre: Genre
    let subCategory: SubCategory

    init(genre: Genre, subCategory: SubCategory) {
        self.genre = genre
        self.subCategory = subCategory
    }

    func fetchSubCategoryEvents(subCategory: SubCategory) {
        MainContentsService.shared.getSubCategoryEvents(subCategoryId: subCategory.id) { events in
            DispatchQueue.main.async {
                self.subCategoryEvents = events ?? []
            }
        }
    }

    func fetchOpenSoonEvents() {
        MainContentsService.shared.getCategoryOpenSoonEvents(categoryId: genre.id) { events in
            DispatchQueue.main.async {
                self.openSoonEvents = events ?? []
            }
        }
    }
}
