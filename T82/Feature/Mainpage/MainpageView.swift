import SwiftUI

struct MainpageView: View {
    
    @StateObject private var viewModel = MainPageViewModel()
    @State private var selectedGenre: Genre = .all
    @State private var selectedIndex: Int = 4
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        
                        // 중앙 버튼을 눌렀을 때 모든 섹션을 표시
                        if selectedIndex == 4 {
                            CustomNavigationBar(
                                isDisplayLeftBtn: true,
                                isDisplayRightBtn: true,
                                isDisplayTitle: true,
                                leftBtnAction: {},
                                rightBtnAction: {},
                                lefttBtnType: .home,
                                rightBtnType: .search,
                                Title: "T82"
                            )
                            .padding()
                            
                            ScrollView{
                                // 메인 랭킹(현재 판매 중인 티켓 중 판매량 많은 순)
                                if viewModel.mainTicketTopRanking.isEmpty {
                                    Text("404 Not Found")
                                        .padding()
                                } else {
                                    TabView {
                                        ForEach(viewModel.mainTicketTopRanking) { event in
                                            VStack(alignment: .leading) {
                                                Image("sampleImg")
                                                    .resizable()
                                                    .frame(height: 200)
                                                    .cornerRadius(10)
                                            }
                                            .padding(.vertical, 0)
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                    .frame(height: 200)
                                }
                                
                                // 장르별 랭킹 이벤트
//                                GenreRankingSectionView(selectedGenre: $selectedGenre)
                                
                                // 특별 할인 이벤트
//                                SectionView(title: "특별 할인", items: viewModel.mainTicketDiscountsRanking, topImages: nil, selectedGenre: Binding<Genre?>(
//                                    get: { selectedGenre },
//                                    set: { newValue in
//                                        if let newValue = newValue {
//                                            selectedGenre = newValue
//                                        }
//                                    }
//                                ))
                                    
                                // 오픈 예정 이벤트
//                                SectionView(title: "OPEN SOON", items: viewModel.mainTicketOpenSoon, topImages: nil, selectedGenre: Binding<Genre?>(
//                                    get: { selectedGenre },
//                                    set: { newValue in
//                                        if let newValue = newValue {
//                                            selectedGenre = newValue
//                                        }
//                                    }
//                                ))
                            }
                            .padding(.bottom, 100)

                        } else if selectedIndex == 3 {
                            MyPageView(myPageSelectedTab: .myInfoEditing)
                        } else if selectedIndex == 0 {
                            MyPageView(myPageSelectedTab: .myTicket)
                        }
                    }
                    .padding(.horizontal)
            }
                VStack {
                    Spacer()
                    tabBarView(selectedIndex: $selectedIndex)
                        .background(Color.white) // 흰색 배경 추가
                }
            }
            .edgesIgnoringSafeArea(.bottom) // 안전 영역 무시
            .onAppear(){
                viewModel.fetchMainPageData()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - 배너 자동 스크롤
    
}

struct MainpageView_Previews: PreviewProvider {
    static var previews: some View {
        MainpageView()
    }
}
