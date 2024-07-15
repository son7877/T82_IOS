import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            // 배경 이미지
            Image("sampleImg")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .clipped()

            Rectangle()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .clipped()

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
            .padding(.top, 100) // 컨텐츠 상단 위치 조정
        }
        .frame(height: 300) // 원하는 높이 설정
        .edgesIgnoringSafeArea(.top) // 상단 영역 무시
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
