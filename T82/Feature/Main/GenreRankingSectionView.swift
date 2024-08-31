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
                ScrollView(.horizontal, showsIndicators: false) {
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

            if viewModel.mainTicketCategoryRanking.isEmpty {
                Text("404 GenreRanking Not Found")
                    .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.mainTicketCategoryRanking) { content in
                            NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: content.eventInfoId))) {
                                VStack {
                                    AsyncImage(url: URL(string: content.imageUrl)) {
                                        image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 100, height: 150)

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
        }
        .padding(.vertical)
    }
}
