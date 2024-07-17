import SwiftUI

struct CustomTabView: View {
    @Binding var selectedIndex: Int

    var body: some View {
        ZStack {
            HStack {
                CustomTabBarButton(selectedIndex: $selectedIndex, index: 0, label: "내 예매", systemImageName: "ticket")
                CustomTabBarButton(selectedIndex: $selectedIndex, index: 1, label: "MD SHOP", systemImageName: "film")

                Spacer().frame(width: 70) // 가운데 버튼 공간 확보

                CustomTabBarButton(selectedIndex: $selectedIndex, index: 2, label: "검색", systemImageName: "magnifyingglass")
                CustomTabBarButton(selectedIndex: $selectedIndex, index: 3, label: "마이페이지", systemImageName: "person")
            }
            .frame(height: 60)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(20)
            .shadow(radius: 5)

            // 가운데 버튼
            Button(action: {
                selectedIndex = 4
            }) {
                Image("homeIcon")
                    .foregroundColor(.white)
                    .padding()
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .offset(y: -20) // 값을 조금 더 올립니다
        }
        .offset(y: -18) // 값을 조금 더 올립니다
    }
}
