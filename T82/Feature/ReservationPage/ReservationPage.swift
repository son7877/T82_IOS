import SwiftUI

struct ReservationPage: View {
    @State private var selectedDate: Date? = nil
    @State private var availableTimes: [String] = []
    @State private var selectedTime: String? = nil
    @State private var availableSeats: String = ""

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
    
    // 더미 데이터: 날짜별 예약 가능한 시간대
    private let dummyTimeData: [String: [String]] = [
        "7/13": ["10:30", "12:15", "13:10", "15:20"],
        "7/14": ["09:00", "11:45", "14:00", "16:30"],
        "7/15": ["08:00", "10:30", "12:30", "14:30"]
    ]
    
    // 더미 데이터: 시간대별 예약 가능한 좌석 정보
    private let dummySeatData: [String: String] = [
        "10:30": "스탠딩 P석 293 / 스탠딩 R석 213 / 지정석 P석 0석 / 지정석 R석 5 / 지정석 S석 6 / 지정석 A석 0석 / 지정석 B석 0석",
        "12:15": "스탠딩 P석 150 / 스탠딩 R석 100 / 지정석 P석 20석 / 지정석 R석 30 / 지정석 S석 40 / 지정석 A석 50석 / 지정석 B석 60석"
    ]

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                // 배경 이미지와 반투명 Rectangle 겹치기
                Image("sampleImg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 270)
                    .clipped()
                    .overlay(
                        Rectangle()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 270)
                            .opacity(0.8)
                            .clipped()
                    )
                    .padding(.top, 45)
                
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
                    .padding(.top, 40) // Safe Area 적용
                    
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

                    .padding(.horizontal, 20)
                    .padding(.leading, -70)
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
                                    // 더미 데이터를 사용하여 예약 가능한 시간대를 설정
                                    availableTimes = dummyTimeData[dateFormatter.string(from: date)] ?? []
                                    selectedTime = nil
                                    availableSeats = ""
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
                
                if !availableTimes.isEmpty {
                    Text("시간 선택")
                        .font(.headline)
                        .padding(.leading, 20)
                        .padding(.top, 16)
                    
                    HStack(spacing: 10) {
                        ForEach(availableTimes, id: \.self) { time in
                            Button(action: {
                                selectedTime = time
                                // 더미 데이터를 사용하여 예약 가능한 좌석 정보를 설정
                                availableSeats = dummySeatData[time] ?? ""
                            }) {
                                Text(time)
                                    .padding(.horizontal, 10)
                                    .frame(minWidth: 70, minHeight: 40)
                                    .background(selectedTime == time ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.black) // 텍스트 색상 검정으로 설정
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                
                if !availableSeats.isEmpty {
                    Text("잔여 좌석")
                        .font(.headline)
                        .padding(.leading, 20)
                        .padding(.top, 16)
                    
                    ZStack {
                        Rectangle()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 32, height: 100)
                            .opacity(0.1)
                            .cornerRadius(10)
                        
                        Text(availableSeats)
                            .font(.subheadline)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 16)
                }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationPage()
    }
}
