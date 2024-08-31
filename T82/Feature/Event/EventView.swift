import SwiftUI

struct EventView: View {
    
    @State var selection : EventTabInfo
    @State private var selectedIndex: Int = 0
    @Namespace private var animation
    
    var body: some View {
        VStack{
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {},
                rightBtnAction: {},
                lefttBtnType: .home,
                rightBtnType: .search,
                Title: "이벤트"
            ).padding()
            
            animate()
            
            EventTabView(selection: selection)
            
            Spacer()
            
        }
    }
    
    @ViewBuilder
    private func animate() -> some View{
        HStack{
            ForEach(EventTabInfo.allCases, id: \.self){ item in
                VStack{
                    Text(item.rawValue)
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity/2, minHeight: 30)
                        .foregroundColor(selection == item ? .black : .customGray1)
                    if selection == item {
                        Capsule()
                            .foregroundColor(.customPink)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selection = item
                    }
                }
            }
        }
    }
    
    
}

