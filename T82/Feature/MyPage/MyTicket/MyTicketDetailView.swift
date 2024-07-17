import SwiftUI
import PopupView

struct MyTicketDetailView: View {
    
    @StateObject private var myTicketViewModel = MyTicketViewModel()
    let ticket: MyTicket
    
    var body: some View {
        ZStack{
            Image("myticketDetail")
                .resizable()
                .scaledToFit()
                .shadow(radius: 6, x: 0, y: 5)
                .padding()
            VStack{
                // 추후에 QR 이미지로 변경
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.white)
                    .padding()
                
                Text(ticket.SectionName + "구역")
                    .font(.title2)
                    .padding()
                
                Text("\(ticket.rowNum)열 \(ticket.columnNum)번")
                    .font(.title2)
                    .padding()
                
                HStack{
                    Button(
                        action: {
                            // 리뷰 등록 alert 띄우기
                            myTicketViewModel.reviewAlert.toggle()
                        },
                        label: {
                            Text("리뷰 등록")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                    )
                    .background(.customRed)
                    .clipShape(Capsule())
                    .padding()
                    
                    Button(
                        action: {},
                        label: {
                            Text("환불 신청")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                    )
                    .background(.customRed)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }.popup(isPresented: $myTicketViewModel.reviewAlert){
            MyReviewFloatingView(isPresented: $myTicketViewModel.reviewAlert)
        } customize: {
            $0
                .type(.toast)
                .position(.center)
                .appearFrom(.leftSlide)
                .animation(.spring)
                .closeOnTap(false)
        }
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myTicket)
}
