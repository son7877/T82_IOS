import SwiftUI

struct GenreRankingSectionView: View {
    @Binding var selectedGenre: Genre
    @ObservedObject var viewModel: MainPageViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("장르 별 랭킹")
                .font(.headline)
                .padding(.horizontal)
            
            HStack {
                ForEach(Genre.allCases) { genre in
                    Button(action: {
                        selectedGenre = genre
                        viewModel.fetchMainTicketCategoryRanking(for: genre)
                    }) {
                        Text(genre.displayName)
                            // 폰트 크기
                            .padding(.vertical,7)
                            .padding(.horizontal, 12)
                            .background(selectedGenre == genre ? Color.customred : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.mainTicketCategoryRanking) { event in
                        VStack {
                            Image("sampleImg")
                                .resizable()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                            
                            Text(event.title)
                                .font(.caption)
                                .frame(width: 100)
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}
