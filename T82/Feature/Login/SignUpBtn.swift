import SwiftUI

// MARK: - 회원가입 버튼
struct SignUpButton: View {
    var body: some View {
        NavigationLink(
            destination: SignUpView(),
            label: {
                Text("회원가입")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.customOrange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        )
    }
}

