import SwiftUI

struct MyTicketView: View {
    @StateObject private var viewModel = MyTicketViewModel()
    
    var body: some View {
        ForEach(viewModel.MyTicketContents, id: \.self){ item in
            ZStack{
                Image("myTicket")
                    .shadow(radius: 6, x: 0, y: 5)
                
                HStack{
                    Image("sampleImg")
                        .resizable()
                        .frame(width: 80, height: 100)
                        .padding(.bottom, 10)
                        .padding(.leading, 25)
                    
                    VStack {
                        Text(item.title)
                        Text(item.eventStartTime.formmatedDay+" "+item.eventStartTime.formattedTime)
                        Text(item.SectionName+"구역")
                        Text("\(item.rowNum)열 \(item.columnNum)번")
                    }
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    MyPageView()
}
