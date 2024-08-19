import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedGenre: Genre = .concert
    @State var selectedIndex: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                contentForSelectedIndex()
                VStack {
                    Spacer()
                    CustomTabBarView(selectedIndex: $selectedIndex)
                        .background(Color.white)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                viewModel.fetchMainPageData()
                requestNotificationPermission()
            }
        }
        .navigationBarBackButtonHidden()
        .onDisappear {
            selectedIndex = 4
        }
    }
    
    @ViewBuilder
    private func contentForSelectedIndex() -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                switch selectedIndex {
                case 4:
                    mainContentView()
                case 3:
                    MyPageView(myPageSelectedTab: .myInfoEditing)
                case 2:
                    SearchResultsView(viewModel: SearchViewModel())
                case 1:
                    EventView(selection: .firstCoupons)
                case 0:
                    MyPageView(myPageSelectedTab: .myTicket)
                default:
                    EmptyView()
                }
            }
        }
    }
    
    @ViewBuilder
    private func mainContentView() -> some View {
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
            
            mainTicketTopRankingView()
            
            GenreRankingSectionView(selectedGenre: $selectedGenre, viewModel: viewModel)
            
            SectionView(title: "OPEN SOON", viewModel: viewModel, items: viewModel.mainTicketOpenSoon, isShowOpenDate: true)
            
            Rectangle()
                .frame(height: 100)
                .foregroundColor(.white)
        }
        .padding(.bottom, 95)
    }
    
    @ViewBuilder
    private func mainTicketTopRankingView() -> some View {
        if viewModel.mainTicketTopRanking.isEmpty {
            Text("404 MainRanking Not Found")
                .padding()
        } else {
            TabView {
                ForEach(viewModel.mainTicketTopRanking) { event in
                    NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.eventInfoId))
                        .navigationBarHidden(true)){
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: event.imageUrl)) {
                                image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
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

