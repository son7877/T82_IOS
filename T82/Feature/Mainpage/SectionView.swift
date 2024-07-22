import SwiftUI

struct SectionView<Item: Identifiable>: View where Item: EventTitleProtocol {
    let title: String
    @ObservedObject var viewModel: MainPageViewModel
    let items: [Item]
    var isShowOpenDate: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            GeometryReader { geometry in
                HStack {
                    Text("<")
                        .font(.largeTitle)
                        .padding(.leading, 0)
                        .foregroundColor(.customgray1)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(items) { item in
                                NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: item.id))) {
                                    VStack {
                                        Image("sampleImg")
                                            .resizable()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                        
                                        Text(item.title)
                                            .font(.caption)
                                            .frame(width: 100)
                                            .foregroundColor(.black)
                                        
                                        if isShowOpenDate {
                                            // 오픈 시간 표시
                                        }
                                    }
                                    .padding(.horizontal, 5)
                                }
                            }
                        }
                        .frame(minWidth: geometry.size.width)
                    }
                    
                    Text(">")
                        .font(.largeTitle)
                        .padding(.trailing, 0)
                        .foregroundColor(.customgray1)
                }
            }
            .frame(height: 150) // Adjust the height as needed
        }
        .padding(.vertical)
    }
}

protocol EventTitleProtocol {
    var title: String { get }
    var id: Int { get }
}

extension MainContents: EventTitleProtocol {}
