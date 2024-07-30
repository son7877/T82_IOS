import SwiftUI

struct MyTicketView: View {
    
    @StateObject private var viewModel = MyTicketViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("로딩 중...")
                    .padding()
            } else if viewModel.isEmpty {
                Text("내 예매 내역이 없습니다")
                    .font(.headline)
                    .padding()
            } else {
                ForEach(viewModel.MyTicketContents, id: \.self) { ticket in
                    ZStack {
                        Image("myTicket")
                            .shadow(radius: 6, x: 0, y: 5)
                            .onTapGesture {
                                viewModel.selectedTicket = ticket
                                viewModel.showModal = true
                            }
                        HStack {
                            Image("sampleImg")
                                .resizable()
                                .frame(width: 80, height: 100)
                                .padding(.bottom, 10)
                                .padding(.leading, 25)
                             
                            VStack {
                                Text("\(ticket.eventStartTime)")
                                    .padding(.bottom, 1)
                                Text("\(ticket.sectionName)구역")
                                Text("\(ticket.rowNum)열 \(ticket.columnNum)번")
                                    .padding(.bottom, 10)
                            }
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $viewModel.showModal) {
            if let ticket = viewModel.selectedTicket {
                MyTicketDetailView(ticket: ticket)
            }
        }
        .background(Rectangle()
            .frame(height: 100)
            .foregroundColor(.white))
        .onAppear {
            viewModel.fetchMyTicket(page: 0, size: 5)
        }
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myTicket)
}
