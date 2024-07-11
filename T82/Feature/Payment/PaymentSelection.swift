//
//  PaymentSelection.swift
//  T82
//
//  Created by 안홍범 on 7/11/24.
//

import SwiftUI

struct PaymentSelection: View{
    
    var body: some View{
        Text("결제 방법")
            .font(.system(size: 15))
            .foregroundStyle(.gray)
            .padding(.trailing, 250)
            .padding(.bottom, 5)
        
        Image("toss")
            .resizable()
            .frame(width: 100, height: 50)
            .border(.customPink, width: 2)
            .padding(.trailing, 250)
    }
}

