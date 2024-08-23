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
                    .font(.caption2)
            }
            .padding(.horizontal)
            .foregroundColor(selectedIndex == index ? .primary : .secondary)
        }
    }
}
