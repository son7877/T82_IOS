//
//  MainView.swift
//  T82
//
//  Created by 안홍범 on 7/14/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: MainTabInfo = .home
    @Namespace private var mainAnimation
    
    var body: some View {
        CustomNavigationBar( // 커스텀 네비게이션 바 사용 방법
            isDisplayLeftBtn: true,
            isDisplayRightBtn: true,
            isDisplayTitle: true,
            leftBtnAction: {},
            rightBtnAction: {},
            lefttBtnType: .home,
            rightBtnType: .search,
            Title: ""
        )
        .padding()
        
        MainTabView(selection: selectedTab)
        
        Spacer()
        
        mainAnimate()
    }
    
    @ViewBuilder
    private func mainAnimate() -> some View{
        HStack{
            ForEach(MainTabInfo.allCases, id: \.self){ item in
                VStack{
                    Text(item.rawValue)
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity/2, minHeight: 30)
                        .foregroundColor(selectedTab == item ? .black : .customGray1)
                    if selectedTab == item {
                        Capsule()
                            .foregroundColor(.customPink)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "Tab", in: mainAnimation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedTab = item
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
