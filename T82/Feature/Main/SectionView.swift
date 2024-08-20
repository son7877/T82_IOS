import SwiftUI

struct SectionView<Item: Identifiable>: View where Item: EventTitleProtocol {
    let title: String
    @ObservedObject var viewModel: MainViewModel
    let items: [Item]
    var isShowOpenDate: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            GeometryReader { geometry in
                HStack {
                    if viewModel.mainTicketOpenSoon.isEmpty {
                        Text("Coming Soon ...")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(items) { item in
                                    NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: item.id))) {
                                        VStack {
                                            AsyncImage(url: URL(string: item.imageUrl)) {
                                                image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 100, height: 150)
                                            
                                            Text(item.title)
                                                .font(.caption)
                                                .frame(width: 100)
                                                .foregroundColor(.black)
                                            
                                            if isShowOpenDate {
                                                Text("\(dateFormating(date: item.bookStartTime)) 오픈")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                }
                            }
                            .frame(minWidth: geometry.size.width)
                        }
                        .padding()
                    }
                }
            }
            .frame(height: 200)
        }
    }
    private func dateFormating(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date!)
    }
}

protocol EventTitleProtocol {
    var title: String { get }
    var imageUrl: String { get }
    var id: Int { get }
    var bookStartTime: String { get }
}

extension MainContents: EventTitleProtocol {}

