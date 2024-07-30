import SwiftUI

struct ReservationView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @State private var selectedDate: Date? = nil
    @State private var selectedTime: Date? = nil
    @State private var availableSeats: String = ""
    @State private var selectedEventId: Int? = nil
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
            
            ScrollView{
                // MARK: - 이벤트 날짜 선택
                VStack(alignment: .leading, spacing: 10) {
                    Text("날짜 선택")
                        .font(.headline)
                        .padding(.leading, 20)
                        .padding(.top, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            let uniqueDates = Array(Set(viewModel.availableDates.map { $0.eventStartTime.stripTime() }))
                            ForEach(uniqueDates.sorted(), id: \.self) { date in
                                Button(action: {
                                    selectedDate = date
                                    selectedTime = nil
                                    availableSeats = ""
                                }) {
                                    Text(date.formmatedDay)
                                        .font(.subheadline)
                                        .padding(10)
                                        .background(selectedDate?.isSameDay(as: date) == true ? Color.customred : Color.gray)
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
                            .padding(.leading, 20)
                            .padding(.top, 16)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.availableTimes(for: selectedDate), id: \.self) { time in
                                    Button(action: {
                                        selectedTime = time
                                        if let eventId = viewModel.availableDates.first(where: { $0.eventStartTime == time })?.eventId {
                                            viewModel.fetchAvailableSeats(eventId: eventId)
                                            selectedEventId = eventId
                                        }
                                    }) {
                                        Text(timeFormatted(time))
                                            .font(.subheadline)
                                            .padding(10)
                                            .background(selectedTime == time ? Color.customred : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // MARK: - 좌석 현황
                    if viewModel.seatsFetchError {
                        Text("잔여 좌석 정보를 불러올 수 없습니다.")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding(.leading, 20)
                            .padding(.top, 16)
                    } else if !viewModel.getAvailableSeatsCountString().isEmpty {
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
                                .foregroundColor(.customred)

                            Text(viewModel.getAvailableSeatsCountString())
                                .font(.subheadline)
                                .padding(10)
                                .background(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            
            Spacer()

            VStack {
                if let eventId = selectedEventId {
                    TicketingProcessBtn(
                        destination: SelectSeatView(eventId: eventId),
                        title: "좌석 선택"
                    )
                } else {
                    Text("좌석 선택")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 60)
                        .background(Color.gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical,1)
                }
            }
        }
        .navigationBarBackButtonHidden()
//        .edgesIgnoringSafeArea(.bottom)
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
