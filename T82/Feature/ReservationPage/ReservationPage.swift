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
        VStack {
            ZStack {
                // 배경 이미지와 반투명 Rectangle 겹치기
                ZStack {
                    Image("sampleImg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .clipped()
                    
                    Rectangle()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .opacity(0.8)
                        .clipped()
                }
                .padding(.bottom, 60)
                
                VStack(spacing: 0) {
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
                    // 상단 위치 조정
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)

                    VStack(alignment: .leading, spacing: 10) {
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
                        .padding()
                        Spacer()
                    }
                    .padding(.top, 14)
                    .padding(.leading, -70)// 컨텐츠 상단 위치 조정
                    
                    Spacer()
                }
            }
            
            VStack(alignment: .leading) {
                Text("날짜 선택")
                    .font(.headline)
                    .padding(.leading, 20)
                    .padding(.top, -40) // 위쪽 간격 줄이기
                    .padding(.bottom, 0) // 아래쪽 간격 줄이기
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(dates, id: \.self) { date in
                            Button(action: {
                                if isDateSelectable(date) {
                                    selectedDate = date
                                }
                            }) {
                                VStack {
                                    Image(systemName: isDateSelectable(date) ? (selectedDate == date ? "expiredDate" : "date") : "selectedDate")
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
            }
            .padding(.bottom, 190) // 스크롤뷰 하단 위치 조정
            
            VStack {
                Divider()
                    .padding()
                TicketingProcessBtn(
                    destination: PaymentCompleteView(),
                    title: "좌석 선택"
                )
                .padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.top) // 상단 영역 무시
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationPage()
    }
}
