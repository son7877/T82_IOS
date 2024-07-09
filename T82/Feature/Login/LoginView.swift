//
//  LoginView.swift
//  T82
//
//  Created by 안홍범 on 7/8/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Version 1.0.0")
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
