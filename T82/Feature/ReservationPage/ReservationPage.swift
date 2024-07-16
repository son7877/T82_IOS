import SwiftUI

struct ReservationPage: View {
    @State private var selectedDate: Date? = nil
    private let dates: [Date] = {
        var dates = [Date]()
        let calendar = Calendar.current
        let today = Date()
        
        for i in -3...3 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
        return dates
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    private func isDateSelectable(_ date: Date) -> Bool {
        return !Calendar.current.isDateInToday(date)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                // 배경 이미지와 반투명 Rectangle 겹치기
                Image("sampleImg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .clipped()
                    .overlay(
                        Rectangle()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 300)
                            .opacity(0.8)
                            .clipped()
                    )
                
                VStack {
                    CustomNavigationBar( // 커스텀 네비게이션 바 사용 방법
                        isDisplayLeftBtn: true,
                        isDisplayRightBtn: true,
                        isDisplayTitle: false,
                        leftBtnAction: {},
                        rightBtnAction: {},
                        lefttBtnType: .back,
                        rightBtnType: .mylike,
                        Title: "Title"
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    
                    HStack(spacing: 20) {
                        Image("sampleImg")
                            .resizable()
                            .frame(width: 150, height: 200)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("제목1")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("장소1")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Text("관람 가능 나이")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            HStack {
                                ForEach(0..<4) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            Text("공연 기간")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 14)
                    .padding(.horizontal, 20)
                }
            }
            .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("날짜 선택")
                    .font(.headline)
                    .padding(.leading, 20)
                    .padding(.top, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(dates, id: \.self) { date in
                            Button(action: {
                                if isDateSelectable(date) {
                                    selectedDate = date
                                }
                            }) {
                                ZStack {
                                    Image("date")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                    
                                    Text(dateFormatter.string(from: date))
                                        .font(selectedDate == date ? .headline : .subheadline)
                                        .foregroundColor(selectedDate == date ? .black : .gray)
                                }
                            }
                            .disabled(!isDateSelectable(date))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                
                Text("시간 선택")
                    .font(.headline)
                    .padding(.leading, 20)
                    .padding(.top, 16)
                
                HStack {
                    Button(action: { /* 시간 선택 로직 */ }) {
                        Text("10:30")
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    Button(action: { /* 시간 선택 로직 */ }) {
                        Text("12:15")
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    Button(action: { /* 시간 선택 로직 */ }) {
                        Text("13:10")
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    Button(action: { /* 시간 선택 로직 */ }) {
                        Text("15:20")
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                Text("잔여 좌석")
                    .font(.headline)
                    .padding(.leading, 20)
                    .padding(.top, 16)
                
                Rectangle()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .opacity(0.8)
                    .clipped()
//                Rectangle()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width, height: 300)
                Text("통신으로 내용 받아오면 됨")
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Spacer()
            
            VStack {
                Divider()
                    .padding()
                TicketingProcessBtn(
                    destination: PaymentCompleteView(),
                    title: "좌석 선택"
                )
                .padding(.bottom, 20)
            }
            .background(Color.white)
        }
//        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationPage()
    }
}
