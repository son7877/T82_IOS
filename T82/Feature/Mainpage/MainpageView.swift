import SwiftUI

struct MainpageView: View {
    @State private var selectedGenre: Genre = .all
    @State private var selectedIndex: Int = 4
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {

                    VStack(alignment: .leading) {
                        // 중앙 버튼을 눌렀을 때 모든 섹션을 표시
                        if selectedIndex == 4 {
                            CustomNavigationBar(
                                isDisplayLeftBtn: true,
                                isDisplayRightBtn: true,
                                isDisplayTitle: true,
                                leftBtnAction: {},
                                rightBtnAction: {},
                                lefttBtnType: .home,
                                rightBtnType: .search,
                                Title: "T82"
                            )
                            .padding()
                            
                            // 여기부터 스크롤 뷰
                            ScrollView{
                                // 장르별 랭킹 이벤트
                                GenreRankingSectionView(selectedGenre: $selectedGenre)
                                
                                // 특별 할인 이벤트
                                SectionView(title: "특별 할인", items: specialDiscountItems, topImages: nil, selectedGenre: Binding<Genre?>(
                                    get: { selectedGenre },
                                    set: { newValue in
                                        if let newValue = newValue {
                                            selectedGenre = newValue
                                        }
                                    }
                                ))
                                    
                                // 오픈 예정 이벤트
                                SectionView(title: "OPEN SOON", items: opensoonItems, topImages: nil,selectedGenre: Binding<Genre?>(
                                    get: { selectedGenre },
                                    set: { newValue in
                                        if let newValue = newValue {
                                            selectedGenre = newValue
                                        }
                                    }
                                ))
                                
                                // 여기까지 스크롤 뷰
                            }
                            .padding(.bottom, 100)

                        } else if selectedIndex == 3 {
                            MyPageView(myPageSelectedTab: .myInfoEditing)
                        }
                    }
                    .padding(.horizontal)
            }
                
                VStack {
                    Spacer()
                    tabBarView(selectedIndex: $selectedIndex)
                        .background(Color.white) // 흰색 배경 추가
                }
            }
            .edgesIgnoringSafeArea(.bottom) // 안전 영역 무시
        }
    }
}
    

struct GenreRankingSectionView: View {
    @Binding var selectedGenre: Genre
    
    var body: some View {
        SectionView(
            title: "장르별 랭킹",
            items: itemsForSelectedGenre(selectedGenre),
            topImages: topRankingImages,
            selectedGenre: Binding<Genre?>(
                get: { selectedGenre },
                set: { newValue in
                    if let newValue = newValue {
                        selectedGenre = newValue
                    }
                }
            )
        )
    }
    
    func itemsForSelectedGenre(_ genre: Genre) -> [Item] {
        switch genre {
        case .all:
            return genreRankingItems
        case .musical:
            return musicalItems
        case .concert:
            return concertItems
        case .sports:
            return sportsItems
        }
    }
}

enum Genre {
    case all, musical, concert, sports
}

struct SectionView: View {
    let title: String
    let items: [Item]
    let topImages: [String]?
    @Binding var selectedGenre: Genre?
    
    init(title: String, items: [Item], topImages: [String]? = nil, selectedGenre: Binding<Genre?>? = nil) {
        self.title = title
        self.items = items
        self.topImages = topImages
        self._selectedGenre = selectedGenre ?? .constant(nil)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let topImages = topImages {
                TabView {
                    ForEach(topImages, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .clipped()
                            .shadow(radius: 10)
                    }
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle())
                .padding(.bottom, 10)
            }
            
            HStack {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                if title == "장르별 랭킹" {
                    HStack {
                        Button(action: {
                            selectedGenre = .musical
                        }) {
                            Text("뮤지컬")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .cornerRadius(5)
                                )
                        }
                        Button(action: {
                            selectedGenre = .concert
                        }) {
                            Text("콘서트")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .cornerRadius(5)
                                )
                        }
                        Button(action: {
                            selectedGenre = .sports
                        }) {
                            Text("스포츠")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .cornerRadius(5)
                                )
                        }
                    }
                }
                Spacer()
                
                if title == "장르별 랭킹" {
                    NavigationLink(destination: DetailPage(selectedGenre: selectedGenre)) {
                        Text("더 보기")
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items) { item in
                        NavigationLink(destination: ReservationPage()) {
                            VStack(alignment: .leading) {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 200)
                                    .cornerRadius(10)
                                    .clipped()
                                    .shadow(radius: 10)
                                
                                Text(item.title)
                                    .font(.subheadline)
                                
                                if title == "OPEN SOON" {
                                    Text("오픈 날짜")
                                        .font(.caption)
                                }
                                
                                if title == "장르별 랭킹" {
                                    Text("공연 기간")
                                        .font(.caption)
                                } else if title == "특별 할인" {
                                    Text("\(item.discountPercentage ?? 0)% \(item.price ?? 0) 원")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
}

struct Item: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let discountPercentage: Int?
    let price: Int?
    
    init(imageName: String, title: String, discountPercentage: Int? = nil, price: Int? = nil) {
        self.imageName = imageName
        self.title = title
        self.discountPercentage = discountPercentage
        self.price = price
    }
}

// 예제 데이터
let genreRankingItems = [
    Item(imageName: "sampleImg", title: "제목1"),
    Item(imageName: "sampleImg", title: "제목2"),
    Item(imageName: "sampleImg", title: "제목3"),
    Item(imageName: "sampleImg", title: "제목4")
]

let musicalItems = [
    Item(imageName: "sampleImg", title: "뮤지컬1"),
    Item(imageName: "sampleImg", title: "뮤지컬2"),
    Item(imageName: "sampleImg", title: "뮤지컬3"),
    Item(imageName: "sampleImg", title: "뮤지컬4")
]

let concertItems = [
    Item(imageName: "sampleImg2", title: "콘서트1"),
    Item(imageName: "sampleImg2", title: "콘서트2"),
    Item(imageName: "sampleImg2", title: "콘서트3"),
    Item(imageName: "sampleImg2", title: "콘서트4")
]

let sportsItems = [
    Item(imageName: "sampleImg", title: "스포츠1"),
    Item(imageName: "sampleImg", title: "스포츠2"),
    Item(imageName: "sampleImg", title: "스포츠3"),
    Item(imageName: "sampleImg", title: "스포츠4")
]

let specialDiscountItems = [
    Item(imageName: "sampleImg", title: "제목5", discountPercentage: 50, price: 33000),
    Item(imageName: "sampleImg", title: "제목6", discountPercentage: 40, price: 50000),
    Item(imageName: "sampleImg", title: "제목6", discountPercentage: 40, price: 50000),
    Item(imageName: "sampleImg", title: "제목6", discountPercentage: 40, price: 50000)
]

let opensoonItems = [
    Item(imageName: "sampleImg", title: "제목1"),
    Item(imageName: "sampleImg", title: "제목2"),
    Item(imageName: "sampleImg", title: "제목3"),
    Item(imageName: "sampleImg", title: "제목4"),
    Item(imageName: "sampleImg", title: "제목5")
]

// 탑 랭킹 이미지 데이터
let topRankingImages = [
    "sampleImg",
    "sampleImg2",
    "sampleImg",
    "sampleImg",
    "sampleImg"
]

struct MainpageView_Previews: PreviewProvider {
    static var previews: some View {
        MainpageView()
    }
}
