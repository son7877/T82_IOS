import SwiftUI

struct MyFavoriteView: View {
    
    @StateObject private var viewModel = MyFavoriteViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("로딩 중...")
                        .padding()
                } else if viewModel.favoriteList.isEmpty {
                    Text("내 공연 관심 목록이 없습니다")
                        .font(.headline)
                        .padding()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.favoriteList, id: \.self) { favorite in
                            Divider()
                                .foregroundColor(.black)
                            NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: favorite.id))) {
                                ZStack {
                                    Rectangle()
                                        .padding()
                                        .foregroundColor(.white)
                                    HStack {
                                        AsyncImage(url: URL(string: favorite.imageUrl)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 80, height: 100)
                                        .padding(.bottom, 10)
                                        .padding(.leading, 15)
                                        VStack (alignment: .leading){
                                            Text(favorite.title)
                                                .padding(.bottom, 1)
                                                .foregroundColor(.black)
                                            Text(formatEventStartTime(favorite.bookStartTime))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                            Divider()
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMyFavorites()
        }
        .background(Rectangle()
            .frame(height: 100)
            .foregroundColor(.white))
    }
    
    private func formatEventStartTime(_ eventStartTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: eventStartTime)
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분 오픈"
        return dateFormatter.string(from: date!)
    }
}

#Preview {
    MyFavoriteView()
}
