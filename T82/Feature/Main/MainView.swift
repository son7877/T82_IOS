import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedGenre: Genre = .concert
    @State var selectedIndex: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        
                        // 중앙 버튼을 눌렀을 때 모든 섹션을 표시
                        if selectedIndex == 4 {
                            CustomNavigationBar(
                                isDisplayLeftBtn: true,
                                isDisplayRightBtn: false,
                                isDisplayTitle: true,
                                leftBtnAction: {},
                                rightBtnAction: {},
                                lefttBtnType: .home,
                                rightBtnType: .search,
                                Title: "T82"
                            )
                            .padding()
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                // 메인 랭킹(현재 판매 중인 티켓 중 판매량 많은 순)
                                if viewModel.mainTicketTopRanking.isEmpty {
                                    Text("404 MainRanking Not Found")
                                        .padding()
                                } else {
                                    TabView {
                                        ForEach(viewModel.mainTicketTopRanking) { event in
                                            NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.id))) {
                                                VStack(alignment: .leading) {
                                                    Image(event.imageUrl)
                                                        .resizable()
                                                        .frame(width: UIScreen.main.bounds.width, height: 350)
                                                }
                                                .padding(.vertical, 0)
                                            }
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                    .frame(height: 200)
                                    .padding(.vertical, 0)
                                }
                                
                                // 장르별 랭킹 이벤트
                                GenreRankingSectionView(selectedGenre: $selectedGenre, viewModel: viewModel)
                                
                                // 오픈 예정 이벤트
                                SectionView(title: "OPEN SOON", viewModel: viewModel, items: viewModel.mainTicketOpenSoon, isShowOpenDate: true)
                                
                                Rectangle()
                                    .frame(height: 100)
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 95)
                            
                        } else if selectedIndex == 3 {
                            MyPageView(myPageSelectedTab: .myInfoEditing)
                        } else if selectedIndex == 2 {
                            SearchResultsView(viewModel: SearchViewModel())
                        } else if selectedIndex == 1 {
                            EventView(selection: .firstCoupons)
                        } else if selectedIndex == 0 {
                            MyPageView(myPageSelectedTab: .myTicket)
                        }
                    }
                    
                }
                VStack {
                    Spacer()
                    CustomTabBarView(selectedIndex: $selectedIndex)
                        .background(Color.white)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear() {
                viewModel.fetchMainPageData()
                requestNotificationPermission()
            }
        }
        .navigationBarBackButtonHidden()
        .onDisappear(){
            selectedIndex = 4
        }
    }
    
    // 알림 권한 요청
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("알림 오류: \(error.localizedDescription)")
            }
        }
    }
}

struct MainpageView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedIndex: 4)
    }
}
