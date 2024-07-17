//
//  LoginBtn.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import SwiftUI

// MARK: - 로그인 버튼
struct LoginButton: View{
    var body: some View{
        NavigationLink(
            destination: MainpageView(),
            label: {
                Text("로그인")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.customOrange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        )
    }
}
