//
//  CustomTabBarButton.swift
//  T82
//
//  Created by 안홍범 on 7/15/24.
//

import SwiftUI

struct CustomTabBarButton: View {
    
    @Binding var selectedIndex: Int
    let index: Int
    let label: String
    let systemImageName: String

    var body: some View {
        Button(action: {
            selectedIndex = index
        }) {
            VStack {
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                Text(label)
                    .font(.caption)
            }
            .padding(.horizontal)
            .foregroundColor(selectedIndex == index ? .primary : .secondary)
        }
    }
}
