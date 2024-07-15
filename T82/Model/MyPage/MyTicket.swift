import Foundation

struct MyTicket: Hashable {
    
    var title: String
    var eventStartTime: Date
    var SectionName: String
    var rowNum: Int
    var columnNum: Int
    
    init(title: String, eventStartTime: Date, SectionName: String, rowNum: Int, columnNum: Int) {
        self.title = title
        self.eventStartTime = eventStartTime
        self.SectionName = SectionName
        self.rowNum = rowNum
        self.columnNum = columnNum
    }
}
