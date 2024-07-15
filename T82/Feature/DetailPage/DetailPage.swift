import SwiftUI

struct DetailPage: View {
    var selectedGenre: Genre?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: true,
                isDisplayTitle: true,
                leftBtnAction: {
                    presentationMode.wrappedValue.dismiss() // 커스텀 뒤로가기 버튼 액션
                },
                rightBtnAction: {},
                lefttBtnType: .back,
                rightBtnType: .search,
                Title: genreTitle()
            )
            .padding(.top, 70) // 상단 패딩 추가
            
            // Content below the CustomNavigationBar
            if let genre = selectedGenre {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        switch genre {
                        case .musical:
                            SectionView(title: "랭킹", items: musicalItems)
                            SectionView(title: "예정된 공연", items: musicalItems)
                            SectionView(title: "뮤지컬 둘러보기", items: musicalItems)
                        case .concert:
                            SectionView(title: "랭킹", items: concertItems)
                            SectionView(title: "예정된 공연", items: concertItems)
                            SectionView(title: "콘서트 둘러보기", items: concertItems)
                        case .sports:
                            SectionView(title: "랭킹", items: sportsItems)
                            SectionView(title: "예정된 경기", items: sportsItems)
                            SectionView(title: "스포츠 둘러보기", items: sportsItems)
                        default:
                            Text("상세 페이지")
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                    .padding()
                }
            } else {
                Text("상세 페이지")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .navigationBarHidden(true) // 기본 네비게이션 바 숨김
        .edgesIgnoringSafeArea(.top) // 최상단에 위치하도록 설정
    }
    
    func genreTitle() -> String {
        if let genre = selectedGenre {
            switch genre {
            case .musical:
                return "뮤지컬"
            case .concert:
                return "콘서트"
            case .sports:
                return "스포츠"
            default:
                return "상세 페이지"
            }
        } else {
            return "상세 페이지"
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(selectedGenre: .musical)
    }
}
