import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                ScrollView{
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
                        List(viewModel.searchResults) { event in
                            NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.eventInfoId))) {
                                VStack(alignment: .leading) {
                                    Text(event.title)
                                        .font(.headline)
                                    Text("장소: \(event.placeName)")
                                    Text("상영 시간: \(event.runningTime)")
                                }
                                .padding()
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
        }
    }
}
