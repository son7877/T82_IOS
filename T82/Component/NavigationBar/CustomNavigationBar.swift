//
//  CustomNavigationBar.swift
//  T82
//
//  Created by 안홍범 on 7/10/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let isDisplayLeftBtn: Bool
    let isDisplayTitle: Bool
    let isDisplayRightBtn: Bool
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    let lefttBtnType: NavigationBtnType
    let rightBtnType: NavigationBtnType
    let Title: String
    
    init(
        isDisplayLeftBtn: Bool,
        isDisplayRightBtn: Bool,
        isDisplayTitle: Bool,
        leftBtnAction: @escaping () -> Void,
        rightBtnAction: @escaping () -> Void,
        lefttBtnType: NavigationBtnType,
        rightBtnType: NavigationBtnType,
        Title: String
        
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.isDisplayTitle = isDisplayTitle
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.lefttBtnType = lefttBtnType
        self.rightBtnType = rightBtnType
        self.Title = Title
    }
    
    var body: some View {
        HStack{
            if isDisplayLeftBtn{
                Button(
                    action: leftBtnAction,
                    label: {
                        if lefttBtnType == .back{
                            Image("back")
                                .resizable()
                                .frame(width: 15, height: 25)
                                .foregroundColor(.black)
                        } else if lefttBtnType == .home{
                            Image("miniLogo")
                                .resizable()
                                .frame(width: 37, height: 27)
                                .foregroundColor(.black)
                        }
                    }
                )
            }
            
            Spacer()
            
            if isDisplayTitle{
                Text(Title)
                    .font(.title)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            if isDisplayRightBtn{
                Button(
                    action: rightBtnAction,
                    label: {
                        if rightBtnType == .search{
                            Image("search")
                                .resizable()
                                .frame(width: 25, height: 27)
                                .foregroundColor(.black)
                        } else if rightBtnType == .mylike{
                            Image("heart")
                                .resizable()
                                .frame(width: 26, height: 25)
                                .foregroundColor(.black)
                        }
                    }
                )
            }
        }
        .padding(.horizontal,0)
        .frame(height: 20)
    }
    
    struct CustomNavigationBarPreviews: PreviewProvider {
        static var previews: some View {
            
            CustomNavigationBar( // 커스텀 네비게이션 바 사용 방법
                isDisplayLeftBtn: true,
                isDisplayRightBtn: true,
                isDisplayTitle: true,
                leftBtnAction: {},
                rightBtnAction: {},
                lefttBtnType: .back,
                rightBtnType: .mylike,
                Title: "Title"
            )
        }
    }
}
