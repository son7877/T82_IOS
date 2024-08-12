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
                                        Image("sampleImg")
                                            .resizable()
                                            .frame(width: 80, height: 100)
                                            .padding()
                                        VStack {
                                            Text(favorite.title)
                                                .padding(.bottom, 1)
                                                .foregroundColor(.customblack)
//                                            Text(favorite.bookStartTime.formmatedDay)
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
    }
}

#Preview {
    MyFavoriteView()
}
