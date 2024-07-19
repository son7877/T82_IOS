//import SwiftUI
//
//struct GenreRankingSectionView: View {
//    @Binding var selectedGenre: Genre
//    
//    var body: some View {
//        SectionView(
//            title: "장르별 랭킹",
//            items: itemsForSelectedGenre(selectedGenre),
//            topImages: nil,
//            selectedGenre: Binding<Genre?>(
//                get: { selectedGenre },
//                set: { newValue in
//                    if let newValue = newValue {
//                        selectedGenre = newValue
//                    }
//                }
//            )
//        )
//    }
//    
//
//}
