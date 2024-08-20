import SwiftUI
import PopupView

struct MyRefundFloatingView: View {
    
    @ObservedObject var myTicketViewModel: MyTicketViewModel
    @Binding var isPresented: Bool
    @State private var refundReason: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var showCompleteAlert: Bool = false
    @State private var errorMessage: String = ""
    var ticket: MyTicket

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("환불 신청")
                    .font(.headline)
                    .padding(.vertical, 5)
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("환불 사유를 입력해 주세요", text: $refundReason)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .tint(.customPink)
            
            Button(action: {
                FaceIDAuthenticator.shared.authenticateWithFaceID { success, message in
                    if success {
                        myTicketViewModel.requestRefund(for: ticket, reason: refundReason) { success, errorMessage in
                            if success {
                                isPresented = false
                                showCompleteAlert = true
                            } else {
                                self.errorMessage = errorMessage
                                showErrorAlert = true
                            }
                        }
                    } else {
                        self.errorMessage = message ?? "Face ID 인증에 실패했습니다."
                        showErrorAlert = true
                    }
                }
            }) {
                Text("환불 신청")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customred)
            }
        }
        .background(Color.customGray0)
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("환불 실패"),
                message: Text(errorMessage),
                dismissButton: .default(Text("확인"))
            )
        }
        .alert(isPresented: $showCompleteAlert) {
            Alert(
                title: Text("환불 신청 완료"),
                message: Text("환불 신청이 완료되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}
