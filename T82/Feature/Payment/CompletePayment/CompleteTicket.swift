import SwiftUI

struct CompleteTicket: View {
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Image("myTicket")
                    .resizable()
                    .frame(width: geometry.size.width * 0.9, height: 130)
                    .shadow(
                        radius: 5,
                        x: 5, y: 5)
                    .padding(.vertical, 30)
                
                HStack{
                    Image("sampleImg")
                        .resizable()
                        .frame(width: geometry.size.width * 0.2, height: 100)
                        .padding(.leading, 30)
                        .padding(.bottom, 5)
                    VStack{
                        Text("티켓명")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.bottom, 10)
                        
                        Text("날짜")
                            .font(.system(size: 15))
                            .padding(.bottom, 5)
                        
                        Text("좌석 정보")
                            .font(.system(size: 15))
                            .foregroundColor(.customPink)
                            .padding(.bottom, 5)
                    }
                    Spacer()
                }
            }
        }
    }
}

