import SwiftUI

// MARK: - 로그인 버튼
struct LoginButton: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.customOrange)
                .foregroundColor(.white)
                .cornerRadius(20)
        } else {
            Button(action: {
                viewModel.login()
            }) {
                Text("로그인")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.customOrange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .disabled(viewModel.isLoading)
        }
    }
}
