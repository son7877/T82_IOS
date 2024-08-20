import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    CustomNavigationBar(
                        isDisplayLeftBtn: true,
                        isDisplayRightBtn: false,
                        isDisplayTitle: true,
                        leftBtnAction: {},
                        rightBtnAction: {},
                        lefttBtnType: .home,
                        rightBtnType: .search,
                        Title: "공연 검색"
                    )
                    .padding()
                    
                    TextField("공연명을 입력하세요", text: $viewModel.searchWord, onCommit: {
                        viewModel.searchResults(searchWord: viewModel.searchWord)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .tint(.customred)
                    .padding()
                }
                .background(Color.white)
                
                Divider()

                ScrollView {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView("검색 중...")
                                .padding()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        } else if viewModel.searchResults.isEmpty {
                            Text("결과가 없습니다.")
                                .padding()
                        } else {
                            
                            // 검색 결과 리스트
                            Rectangle()
                                .frame(height: 10)
                                .foregroundColor(.clear)
                            
                            ForEach(viewModel.searchResults) { event in
                                NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.eventInfoId))) {
                                    VStack(alignment: .leading) {
                                        Text(event.title)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .padding()
                                        Text("장소: \(event.placeName)")
                                            .foregroundColor(.black)
                                            .padding()
                                        Text("상영 시간: \(event.runningTime)")
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        }
    }
}
