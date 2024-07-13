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
        Text("MyPageView")
    }
}

#Preview {
    MyPageView()
}
