//import SwiftUI
//
//struct SectionView: View {
//    
//    @StateObject private var viewModel = MainPageViewModel()
//    let title: String
//    let items: [MainEvents]
//    
//    @Binding var selectedGenre: Genre?
//    
//    init(title: String, items: [MainEvents], topImages: [String]? = nil, selectedGenre: Binding<Genre?>? = nil) {
//        self.title = title
//        self.items = items
//        self._selectedGenre = selectedGenre ?? .constant(nil)
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            HStack {
//                Text(title)
//                    .font(.headline)
//                    .padding(.bottom, 5)
//                
//                if title == "장르별 랭킹" {
//                    HStack {
//                        Button(action: {
//                            selectedGenre = .musical
//                        }) {
//                            Text("뮤지컬")
//                                .foregroundColor(.white)
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 10)
//                                .background(
//                                    LinearGradient(gradient: Gradient(colors: [.customred, .customorange]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                                        .cornerRadius(5)
//                                )
//                        }
//                        Button(action: {
//                            selectedGenre = .concert
//                        }) {
//                            Text("콘서트")
//                                .foregroundColor(.white)
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 10)
//                                .background(
//                                    LinearGradient(gradient: Gradient(colors: [.customred, .customorange]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                                        .cornerRadius(5)
//                                )
//                        }
//                        Button(action: {
//                            selectedGenre = .sports
//                        }) {
//                            Text("스포츠")
//                                .foregroundColor(.white)
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 10)
//                                .background(
//                                    LinearGradient(gradient: Gradient(colors: [.customred, .customorange]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                                        .cornerRadius(5)
//                                )
//                        }
//                    }
//                }
//                Spacer()
//                
//                if title == "장르별 랭킹" {
//                    NavigationLink(destination: DetailPage(selectedGenre: selectedGenre)) {
//                        Text("더 보기")
//                            .foregroundColor(.custompink)
//                    }
//                }
//            }
//            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 15) {
//                    ForEach(items) { item in
//                        NavigationLink(destination: ReservationPage()) {
//                            VStack(alignment: .leading) {
//                                Image("sampleImg")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 150, height: 200)
//                                    .cornerRadius(10)
//                                    .clipped()
//                                    .shadow(radius: 10)
//                                
//                                Text(item.title)
//                                    .font(.subheadline)
//                                
//                                if title == "OPEN SOON" {
//                                    Text("오픈 날짜")
//                                        .font(.caption)
//                                }
//                                
//                                if title == "장르별 랭킹" {
//                                    Text("공연 기간")
//                                        .font(.caption)
//                                } else if title == "특별 할인" {
//                                    Text("\(item.discountPercentage ?? 0)% \(item.price ?? 0) 원")
//                                        .font(.caption)
//                                        .foregroundColor(.red)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.bottom, 10)
//    }
//}
//
