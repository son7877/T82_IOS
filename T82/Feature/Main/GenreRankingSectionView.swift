import SwiftUI

struct GenreRankingSectionView: View {
    @Binding var selectedGenre: Genre
    @ObservedObject var viewModel: MainViewModel

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
                            .padding(.vertical, 7)
                            .padding(.horizontal, 12)
                            .background(selectedGenre == genre ? Color.customred : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                Spacer()

                NavigationLink(destination: SubCategoryView(
                    title: selectedGenre.displayName,
                    viewModel: SubCategoryViewModel(
                        genre: selectedGenre,
                        subCategory: selectedGenre.subCategories.first!))) {
                    Text("더보기")
                        .padding(.vertical, 7)
                        .padding(.horizontal, 12)
                        .foregroundColor(.customgray1)
                        .background(.white)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.mainTicketCategoryRanking) { content in
                        NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: content.id))) {
                            VStack {
                                Image("sampleImg")
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(10)

                                Text(content.title)
                                    .font(.caption)
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}
