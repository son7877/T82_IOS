import SwiftUI
import PopupView

struct MyReviewFloatingView: View {
    
    @StateObject private var myTicketViewModel = MyTicketViewModel()
    @StateObject private var reviewViewModel = MyReviewViewModel()
    @Binding var isPresented: Bool
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text("리뷰 등록")
                    .font(.headline)
                    .padding(.vertical, 5)
                Spacer()
            }
            .padding(.horizontal)
            
            // 별점 등록
            HStack{
                ForEach(1..<6){ index in
                    Button(action: {
                        rating = index
                    }, label: {
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .foregroundColor(.customPink)
                    })
                }
            }
            .padding()
            
            // 리뷰 내용
            TextField("리뷰를 작성해주세요", text: $reviewText)
                .padding()
                .background(Color.customGray0)
                .cornerRadius(10)
                .padding()
                .tint(.customPink)
            
            Button(action: {
                // 리뷰 등록 통신 후 뷰 닫기
                isPresented = false
                
            }, label: {
                Text("등록")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customPink.opacity(0.8))
                    .cornerRadius(10)
            })
        }
        .background(Color.customGray1.opacity(0.6))
    }
}
