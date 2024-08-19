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
                    
                    // 검색어 입력 필드
                    TextField("검색어를 입력하세요", text: $viewModel.searchWord, onCommit: {
                        viewModel.searchResults(searchWord: viewModel.searchWord)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .tint(.customred)
                    .padding()
                }
                .background(Color.white) // 상단 영역을 배경색으로 고정

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
                            ForEach(viewModel.searchResults) { event in
                                NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.eventInfoId))) {
                                    VStack(alignment: .leading) {
                                        Text(event.title)
                                            .font(.headline)
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
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.gray.opacity(0.1)) // 배경색을 통해 스크롤 영역을 구분
            .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        }
    }
}
