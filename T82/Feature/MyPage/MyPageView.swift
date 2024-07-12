//
//  MyPageView.swift
//  T82
//
//  Created by 안홍범 on 7/12/24.
//

import SwiftUI

struct MyPageView: View {
    
    @State private var selectedTab: MyPageTabInfo = .myTicket
    @Namespace private var animation
    
    var body: some View {
        CustomNavigationBar( // 커스텀 네비게이션 바 사용 방법
            isDisplayLeftBtn: true,
            isDisplayRightBtn: true,
            isDisplayTitle: true,
            leftBtnAction: {},
            rightBtnAction: {},
            lefttBtnType: .home,
            rightBtnType: .location,
            Title: "마이페이지"
        )
        .padding()
        animate()
        MyPageTabView(selection: selectedTab)
    }
    
    @ViewBuilder
    private func animate() -> some View{
        HStack{
            ForEach(MyPageTabInfo.allCases, id: \.self){ item in
                VStack{
                    Text(item.rawValue)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity/2, minHeight: 30)
                        .foregroundColor(selectedTab == item ? .black : .customGray1)
                    if selectedTab == item {
                        Capsule()
                            .foregroundColor(.customPink)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "Tab", in: animation)
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
    MyPageView()
}
