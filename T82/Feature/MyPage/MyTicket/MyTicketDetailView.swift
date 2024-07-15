import SwiftUI

struct MyTicketDetailView: View {
    
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
            }
        }
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myTicket)
}
