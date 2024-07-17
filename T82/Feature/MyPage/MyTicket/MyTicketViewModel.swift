import Foundation

class MyTicketViewModel: ObservableObject{
    
    @Published var MyTicketContents: [MyTicket]
    @Published var showModal = false
    @Published var selectedTicket: MyTicket? = nil
    @Published var reviewAlert = false
    
    // 예시 -> 통신으로 불러올 예정
    init(
        MyTicketContents: [MyTicket] = [
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "A", rowNum: 1, columnNum: 1),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "B", rowNum: 1, columnNum: 2),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "C", rowNum: 1, columnNum: 3),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "D", rowNum: 1, columnNum: 4),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "E", rowNum: 1, columnNum: 5),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "F", rowNum: 1, columnNum: 6),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "G", rowNum: 1, columnNum: 7),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "H", rowNum: 1, columnNum: 8),
            MyTicket(title: "싸이 흠뻑쇼", eventStartTime: Date(), SectionName: "I", rowNum: 1, columnNum: 9),]
    ) {
        self.MyTicketContents = MyTicketContents
    }
}
