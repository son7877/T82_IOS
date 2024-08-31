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
        ZStack {
            if isDisplayTitle {
                Text(Title)
                    .font(.title)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 60) 
            }
            HStack {
                if isDisplayLeftBtn {
                    Button(
                        action: leftBtnAction,
                        label: {
                            if lefttBtnType == .back {
                                Image("back")
                                    .resizable()
                                    .frame(width: 15, height: 25)
                                    .foregroundColor(.black)
                            } else if lefttBtnType == .home {
                                Image("miniLogo")
                                    .resizable()
                                    .frame(width: 37, height: 27)
                                    .foregroundColor(.black)
                            }
                        }
                    )
                }
                
                Spacer()
                
                if isDisplayRightBtn {
                    Button(
                        action: rightBtnAction,
                        label: {
                            if rightBtnType == .search {
                                Image("search")
                                    .resizable()
                                    .frame(width: 25, height: 27)
                                    .foregroundColor(.black)
                            } else if rightBtnType == .mylike {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.customred)
                            } else if rightBtnType == .mydislike {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.customred)
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 0)
        }
        .frame(height: 20) // 네비게이션 바의 표준 높이로 조정
    }
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
