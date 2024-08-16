import SwiftUI
import PopupView

struct MyTicketDetailView: View {
    
    @ObservedObject var myTicketViewModel: MyTicketViewModel
    @ObservedObject var reviewViewModel: MyReviewViewModel
    let ticket: MyTicket
    
    var body: some View {
        ZStack {
            Image("myticketDetail")
                .resizable()
                .scaledToFit()
                .shadow(radius: 6, x: 0, y: 5)
                .padding()
            VStack {
                
                AsyncImage(url: URL(string: ticket.qrCodeUrl ?? ""))
                    .frame(width: 300, height: 300)
                    .foregroundColor(.white)
                    .padding()
                
                Text(ticket.sectionName + "구역")
                    .font(.title2)
                    .padding()
                
                Text("\(ticket.rowNum)열 \(ticket.columnNum)번")
                    .font(.title2)
                    .padding()
                
                HStack {
                    Button(
                        action: {
                            myTicketViewModel.reviewAlert.toggle()
                        },
                        label: {
                            Text("리뷰 등록")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                        }
                    )
                    .background(Color.customRed)
                    .clipShape(Capsule())
                    .padding()
                    
                    Button(
                        action: {
                            myTicketViewModel.refundAlert.toggle()
                        },
                        label: {
                            Text("환불 신청")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                        }
                    )
                    .background(Color.customRed)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }
        
        // 리뷰 팝업
        .popup(isPresented: $myTicketViewModel.reviewAlert) {
            MyReviewFloatingView(
                myTicketViewModel: myTicketViewModel,
                reviewViewModel: reviewViewModel,
                isPresented: $myTicketViewModel.reviewAlert,
                eventInfoId: ticket.eventInfoId)
        } customize: {
            $0
                .type(.toast)
                .position(.center)
                .appearFrom(.leftSlide)
                .animation(.spring)
                .closeOnTap(false)
        }
        
        // 환불 팝업
        .popup(isPresented: $myTicketViewModel.refundAlert) {
            MyRefundFloatingView(
                myTicketViewModel: myTicketViewModel,
                isPresented: $myTicketViewModel.refundAlert,
                ticket: ticket)
        } customize: {
            $0
                .type(.toast)
                .position(.center)
                .appearFrom(.rightSlide)
                .animation(.spring)
                .closeOnTap(false)
        }
    }
}
