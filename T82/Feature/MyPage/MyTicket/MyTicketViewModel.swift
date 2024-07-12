import Foundation

class MyTicketViewModel: ObservableObject{
    @Published var MyTicketContents: [MyTicket]
    
    // 예시
    init(
        MyTicketContents: [MyTicket] = [
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "A", rowNum: 1, columnNum: 1),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "B", rowNum: 1, columnNum: 2),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "C", rowNum: 1, columnNum: 3),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "D", rowNum: 1, columnNum: 4),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "E", rowNum: 1, columnNum: 5),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "F", rowNum: 1, columnNum: 6),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "G", rowNum: 1, columnNum: 7),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "H", rowNum: 1, columnNum: 8),
            MyTicket(title: "KBO 2024", eventStartTime: Date(), SectionName: "I", rowNum: 1, columnNum: 9),]
    ) {
        self.MyTicketContents = MyTicketContents
    }
    
}
