//
//  Test.swift
//  T82
//
//  Created by 안홍범 on 7/19/24.
//

import SwiftUI

struct Test: View {
    
    @StateObject private var viewModel = MainPageViewModel()

    var body: some View {
        ForEach(viewModel.mainTicketTopRanking) { event in
            Text(event.title)
        }
    }
}

#Preview {
    Test()
}
