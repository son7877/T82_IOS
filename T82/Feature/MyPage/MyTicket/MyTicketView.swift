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
                    VStack {
                        ForEach(viewModel.MyTicketContents, id: \.ticketId) { ticket in
                            ZStack {
                                Image("myTicket")
                                    .shadow(radius: 6, x: 0, y: 5)
                                    .onTapGesture {
                                        viewModel.selectedTicket = ticket
                                        viewModel.showModal = true
                                    }
                                HStack {
                                    AsyncImage(url: URL(string: ticket.imageUrl)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 100)
                                    .padding(.bottom, 10)
                                    .padding(.leading, 15)
                                     
                                    VStack (alignment: .leading) {
                                        Text(ticket.eventName.count > 7 ? String(ticket.eventName.prefix(7)) + "..." : ticket.eventName)
                                            .font(.system(size: 20))
                                            .padding(.bottom, 5)
                                            .fontWeight(.bold)
                                        
                                        Text("\(ticket.sectionName)")
                                            .font(.system(size: 15))
                                        Text("\(ticket.rowNum)열 \(ticket.columnNum)번")
                                            .font(.system(size: 15))
                                            .padding(.bottom, 5)
                                        Text(formatEventStartTime(ticket.eventStartTime))
                                            .padding(.bottom, 5)
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15))
                                    }
                                    Spacer()
                                }
                            }
                            .padding()
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
            viewModel.fetchMyTicket()
        }
    }
    
    private func formatEventStartTime(_ eventStartTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: eventStartTime) {
            dateFormatter.dateFormat = "MM/dd HH:mm 입장"
            return dateFormatter.string(from: date)
        }
        return eventStartTime
    }
    
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
