//
//  SignUpView.swift
//  T82
//
//  Created by 안홍범 on 7/8/24.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack
        {
            CustomNavigationBar( // 커스텀 네비게이션 바 사용 방법
                isDisplayLeftBtn: true,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {},
                rightBtnAction: {},
                lefttBtnType: .back,
                rightBtnType: .mylike,
                Title: "회원 가입"
            )
            .padding()
            
            
            
            
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
