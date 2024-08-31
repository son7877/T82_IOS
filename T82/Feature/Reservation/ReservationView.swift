import SwiftUI

struct ReservationView: View {
    
    @ObservedObject var viewModel: ReservationViewModel
    @StateObject private var reviewViewModel = EventCommentViewModel()
    @State private var selectedDate: Date? = nil
    @State private var selectedTime: Date? = nil
    @State private var availableSeats: String = ""
    @State private var selectedEventId: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var averageRating: Int {
        let reviewCount = reviewViewModel.eventInfoReviews.count
        if reviewCount > 0 && viewModel.contentsDetail.rating.isFinite {
            return Int(viewModel.contentsDetail.rating / Double(reviewCount))
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: viewModel.contentsDetail.imageUrl))
                    .aspectRatio(contentMode: .fill)
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
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        rightBtnAction: {
                            if viewModel.isInterested {
                                viewModel.removeInterest()
                            } else {
                                viewModel.addInterest()
                            }
                        },
                        lefttBtnType: .back,
                        rightBtnType: viewModel.isInterested ? .mylike : .mydislike,
                        Title: "Title"
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 20)

                    // MARK: - 공연 상세 정보
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: viewModel.contentsDetail.imageUrl)) {
                            image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 200)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(viewModel.contentsDetail.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(viewModel.contentsDetail.placeName)
                                .font(.subheadline)
                                .foregroundColor(.white)

                            Text("\(viewModel.contentsDetail.ageRestriction)")
                                .font(.subheadline)
                                .foregroundColor(.white)

                            HStack(spacing: 5) {
                                ForEach(0..<5) { index in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(index < averageRating ? .yellow : .gray)
                                }
                            }
                            Text("공연시간: \(viewModel.contentsDetail.runningTime)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            // MARK: - 리뷰 보기
                            NavigationLink(
                                destination: EventCommentView(eventInfoId: viewModel.eventInfoId),
                                label: {
                                    Text("리뷰 \(reviewViewModel.eventInfoReviews.count)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .underline()
                                }
                            )
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(height: 300)
            
            ScrollView {
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
                                if date.formmatedDay != "티켓 만료됨" { // "티켓 만료됨"이 아닌 경우에만 버튼 표시
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
                        destination: SelectSeatView(eventId: eventId, placeId: viewModel.contentsDetail.placeId),
                        title: "좌석 선택"
                    )
                } else {
                    Text("좌석 선택")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 60)
                        .background(Color.gray)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 1)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(){
            reviewViewModel.fetchEventInfoReviews(eventInfoId: viewModel.eventInfoId)
        }
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
