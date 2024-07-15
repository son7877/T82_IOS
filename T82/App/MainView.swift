//import SwiftUI
//
//struct MainView: View {
//    
//    @State private var selectedTab: MainTabInfo = .home
//    @Namespace private var mainAnimation
//    
//    var body: some View {
//        CustomNavigationBar(
//            isDisplayLeftBtn: true,
//            isDisplayRightBtn: true,
//            isDisplayTitle: true,
//            leftBtnAction: {},
//            rightBtnAction: {},
//            lefttBtnType: .home,
//            rightBtnType: .search,
//            Title: ""
//        )
//        .padding()
//        .navigationBarBackButtonHidden()
//        
//        MainTabView(selection: selectedTab)
//        
//        Spacer()
//        
//        mainAnimate()
//    }
//    
//    @ViewBuilder
//    private func mainAnimate() -> some View{
//        HStack{
//            ForEach(MainTabInfo.allCases, id: \.self){ item in
//                VStack{
//                    Text(item.rawValue)
//                        .font(.system(size: 15))
//                        .frame(maxWidth: .infinity/2, minHeight: 30)
//                        .foregroundColor(selectedTab == item ? .black : .customGray1)
//                    if selectedTab == item {
//                        Capsule()
//                            .foregroundColor(.customPink)
//                            .frame(height: 3)
//                            .matchedGeometryEffect(id: "Tab", in: mainAnimation)
//                    }
//                }
//                .onTapGesture {
//                    withAnimation(.easeInOut){
//                        self.selectedTab = item
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    MainView()
//}
