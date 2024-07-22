import SwiftUI

struct ReservationView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @State private var selectedDate: Date? = nil
    @State private var selectedTime: Date? = nil
    @State private var availableSeats: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
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
                            .padding()
                    )
                    .padding(.vertical, 0)
                    .padding(.horizontal, 10)
                
                VStack {
                    CustomNavigationBar(
                        isDisplayLeftBtn: true,
                        isDisplayRightBtn: true,
                        isDisplayTitle: false,
                        leftBtnAction: {
                            presentationMode.wrappedValue.dismiss()
                        },
                        rightBtnAction: {},
                        lefttBtnType: .back,
                        rightBtnType: .mylike,
                        Title: "Title"
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 20)
                    
                    // 공연 상세 정보
                    HStack(spacing: 20) {
                        Image("sampleImg")
                            .resizable()
                            .frame(width: 150, height: 200)
                            .cornerRadius(10)
                            .padding(.vertical, 0)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(viewModel.contentsDetail.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(viewModel.contentsDetail.placeName)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Text("\(viewModel.contentsDetail.ageRestriction) 이상")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            HStack(spacing: 5) {
                                ForEach(0..<5) { index in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(index < Int(viewModel.contentsDetail.rating) ? .yellow : .gray)
                                }
                            }
                            
                            Text("공연시간: \(viewModel.contentsDetail.runningTime)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.leading, -70)
                }
            }
            .frame(height: 300)
            
            // 이벤트 날짜 선택
            VStack(alignment: .leading, spacing: 10) {
                Text("날짜 선택")
                    .font(.headline)
                    .padding(.leading, 10)
                    .padding(.top, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.availableDates.map { $0.eventStartTime }, id: \.self) { date in
                            Button(action: {
                                selectedDate = date
                                selectedTime = nil
                                availableSeats = ""
                            }) {
                                Text(date.formmatedDay)
                                    .padding()
                                    .background(selectedDate == date ? Color.customred : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                if let selectedDate = selectedDate {
                    Text("시간 선택")
                        .font(.headline)
                        .padding(.leading, 10)
                        .padding(.top, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.availableTimes(for: selectedDate), id: \.self) { time in
                                Button(action: {
                                    selectedTime = time
                                    availableSeats = "통신으로 출력"
                                }) {
                                    Text(timeFormatted(time))
                                        .padding()
                                        .background(selectedTime == time ? Color.customred : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                // 좌석 현황
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
            
            Spacer()
            
            VStack {
                TicketingProcessBtn(
                    destination: SelectSeatView(),
                    title: "좌석 선택"
                )
                .padding(.bottom, 20)
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func timeFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(viewModel: ReservationViewModel(eventInfoId: 1))
    }
}
