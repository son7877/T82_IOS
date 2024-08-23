import SwiftUI

struct MyPageView: View {
    
    @State var myPageSelectedTab: MyPageTabInfo
    @State private var selectedIndex: Int = 3
    @Namespace private var animation
    
    var body: some View {
        VStack{
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {},
                rightBtnAction: {},
                lefttBtnType: .home,
                rightBtnType: .search,
                Title: "마이페이지"
            ).padding()
            
            animate()
            
            MyPageTabView(selection: myPageSelectedTab)
            
            Spacer()
            
        }
    }
    
    @ViewBuilder
    private func animate() -> some View{
        HStack{
            ForEach(MyPageTabInfo.allCases, id: \.self){ item in
                VStack{
                    Text(item.rawValue)
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity/2, minHeight: 30)
                        .foregroundColor(myPageSelectedTab == item ? .black : .customGray1)
                    if myPageSelectedTab == item {
                        Capsule()
                            .foregroundColor(.customPink)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.myPageSelectedTab = item
                    }
                }
            }
        }
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myInfoEditing)
}
