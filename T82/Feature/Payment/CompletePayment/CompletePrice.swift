//
//  CompletePrice.swift
//  T82
//
//  Created by 안홍범 on 7/12/24.
//

import SwiftUI

struct CompletePrice: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Rectangle()
                    .fill(.customGray0)
                    .frame(width: geometry.size.width * 0.9, height: 60)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                HStack{
                    Text("결제 가격")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.leading, 40)
                    
                    Spacer()
                    
                    Text("160,000 원")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.customPink)
                        .padding(.trailing, 40)
                }
            }
        }
    }
}

