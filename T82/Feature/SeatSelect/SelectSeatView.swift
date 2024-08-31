import SwiftUI

struct SelectSeatView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = SeatsViewModel()
    @State private var isShowingWebView = false
    var eventId: Int
    var placeId: Int
    
    var body: some View {
        NavigationStack {
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {
                    presentationMode.wrappedValue.dismiss()
                },
                rightBtnAction: {},
                lefttBtnType: .back,
                rightBtnType: .mylike,
                Title: "좌석 선택"
            )
            .padding()
            .navigationBarBackButtonHidden()
            
            SeatsInfo(viewModel: viewModel)
                .frame(maxWidth: 300, maxHeight: 300)
                .padding(.bottom, 30)
                .padding(.horizontal, 20)
                .background(Color.customGray0.opacity(0.7))
                .cornerRadius(10)
            
            SeatsPrice(seatsViewModel: viewModel)
                .padding()
            
            Spacer()
            
            TicketingProcessBtn(
                destination: PaymentView(selectedSeats: viewModel.selectedSeats, eventId: eventId),
                title: "결제 이동"
            )
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.loadSeats(for: placeId)
            viewModel.fetchAvailableSeats(eventId: eventId)
            viewModel.enterAndDisplayWaitingQueue(eventId: eventId)
        }
        .onChange(of: viewModel.showWebView) { show in
            isShowingWebView = show
        }
        .fullScreenCover(isPresented: $isShowingWebView) {
            WaitingQueueView(
                htmlContent: viewModel.htmlContent,
                isPresented: $isShowingWebView,
                viewModel: viewModel,
                eventId: eventId
            )
        }
    }
}
