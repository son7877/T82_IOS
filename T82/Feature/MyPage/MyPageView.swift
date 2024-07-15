//
//  MyPageView.swift
//  T82
//
//  Created by 안홍범 on 7/12/24.
//

import SwiftUI

struct MyPageView: View {
    
    @State var myPageSelectedTab: MyPageTabInfo
    @Namespace private var animation
    
    var body: some View {
        
        animate()
        
        MyPageTabView(selection: myPageSelectedTab)
    }
    
    @ViewBuilder
    private func animate() -> some View{
        HStack{
            ForEach(MyPageTabInfo.allCases, id: \.self){ item in
                VStack{
                    Text(item.rawValue)
                        .font(.system(size: 20))
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
