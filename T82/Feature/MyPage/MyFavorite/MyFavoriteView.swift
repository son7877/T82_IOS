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
                            NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: favorite.id))) {
                                ZStack {
                                    Rectangle()
                                        .shadow(radius: 6, x: 0, y: 5)
                                        .foregroundColor(.customYellow.opacity(0.5))
                                    HStack {
                                        Image("sampleImg")
                                            .resizable()
                                            .frame(width: 80, height: 100)
                                            .padding(.bottom, 10)
                                            .padding(.leading, 25)
                                        
                                        VStack {
                                            Text(favorite.title)
                                                .padding(.bottom, 1)
                                            Text(favorite.bookStartTime.formmatedDay)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("관심 공연 목록", displayMode: .inline)
        }
    }
}

#Preview {
    MyFavoriteView()
}
