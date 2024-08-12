import SwiftUI
import Foundation
import UserNotifications

struct MyTicketView: View {
    
    @StateObject private var viewModel = MyTicketViewModel()
    @StateObject private var reviewViewModel = MyReviewViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.MyTicketContents.isEmpty {
                ProgressView("로딩 중...")
                    .padding()
            } else if viewModel.MyTicketContents.isEmpty {
                Text("내 예매 내역이 없습니다")
                    .font(.headline)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack {
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
                                     
                                    VStack (alignment: .leading) {
                                        Text("\(ticket.eventName)")
                                            .font(.headline)
                                            .padding(.bottom, 10)
                                        Text("\(ticket.eventStartTime)")
                                        Text("\(ticket.sectionName)구역")
                                        Text("\(ticket.rowNum)열 \(ticket.columnNum)번")
                                            .padding(.bottom, 10)
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
                            .onAppear {
                                if ticket == viewModel.MyTicketContents.last && viewModel.currentPage < viewModel.totalPages - 1 {
                                    viewModel.fetchMyTicket(page: viewModel.currentPage + 1, size: 5)
                                }
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView("로딩 중...")
                                .padding()
                        }
                        Rectangle()
                            .frame(height: 100)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showModal) {
            if let ticket = viewModel.selectedTicket {
                MyTicketDetailView(myTicketViewModel: viewModel, reviewViewModel: reviewViewModel, ticket: ticket)
            }
        }
        .background(Rectangle()
            .frame(height: 100)
            .foregroundColor(.white))
        .onAppear(){
            saveStartTime()
        }
    }
    
    // 공연 시작 시간 기기 내부에 저장
    private func saveStartTime(){
        for ticket in viewModel.MyTicketContents {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            if let date = dateFormatter.date(from: ticket.eventStartTime) {
                UserDefaults.standard.set(date, forKey: "Ticket\(ticket.ticketId)_StartTime")
                scheduleNotification(for: date, ticketId: ticket.ticketId)
            }
        }
    }
    
    // 공연 시작 시간 10분 전 UserNotification
    private func scheduleNotification(for date: Date, ticketId: Int) {
        let content = UNMutableNotificationContent()
        content.title = "곧 시작됩니다!"
        content.body = "입장해 주세요!"
        content.sound = .default

        let triggerDate = Calendar.current.date(byAdding: .minute, value: -10, to: date)!
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate), repeats: false)

        let request = UNNotificationRequest(identifier: "Ticket\(ticketId)_Notification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("에러: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myTicket)
}
