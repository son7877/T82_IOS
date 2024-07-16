import SwiftUI

struct MyReviewView: View {
    
    @StateObject private var viewModel = MyReviewViewModel()
    
    var body: some View {
        LazyVStack(pinnedViews: [.sectionHeaders]) {
    
            Section(header: Header()){
                // 내 댓글 리스트
                ForEach(viewModel.MyReviews, id: \.self){ review in
                    VStack{
                        HStack{
                            Text(review.eventTitle)
                                .font(.system(size: 20))
                                .frame(maxWidth: .infinity/2, minHeight: 30)
                            Text(review.content)
                                .font(.system(size: 20))
                                .frame(maxWidth: .infinity/2, minHeight: 30)
                            Spacer()
                            
                            // 뷰모델 별점
                            HStack{
                                ForEach(1..<6){ index in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(index <= review.rating ? .customPink : .customGray1)
                                }
                            }
                        }
                        
                        Text("\(review.reviewDate.formmatedDay) \(review.reviewDate.formattedTime)")
                            .font(.system(size: 15))
                            .foregroundColor(.customGray1)
                            .padding(.bottom, 10)
                    }
                    .background(.customGray0)
                    .padding(.vertical)
                }
            }
        }
    }
}

struct Header: View{
    var body: some View{
        HStack{
            Text("공연명")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity/2, minHeight: 30)
            Text("내용")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity/2, minHeight: 30)
            Text("평점")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity/2, minHeight: 30)
        }
        .padding(.vertical,10)
        .padding(.horizontal, 10)
        .background(.customPink)
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myReview)
//    MyReviewView()
}
