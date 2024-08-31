import SwiftUI

struct MyReviewView: View {
    
    @StateObject private var viewModel = MyReviewViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("로딩 중...")
                    .padding()
            } else if viewModel.MyReviews.isEmpty {
                Text("내 리뷰가 없습니다")
                    .font(.headline)
                    .padding()
            } else {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section(header: Header()){
                        
                        // 내 댓글 리스트
                        ForEach(viewModel.MyReviews) { review in
                            VStack {
                                HStack {
                                    
                                    // 리뷰 이미지
                                    if !(review.reviewPictureUrl == ""){
                                        AsyncImage(url: URL(string: review.reviewPictureUrl ?? ""))
                                        {
                                            image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            EmptyView()
                                        }
                                        .frame(width: 35, height: 50)
                                    } else {
                                        Text("이미지 없음")
                                            .font(.system(size: 20))
                                            .frame(maxWidth: .infinity / 2, minHeight: 30)
                                    }
                                    
                                    Text(review.content)
                                        .font(.system(size: 20))
                                        .frame(maxWidth: .infinity / 2, minHeight: 30)
                                    
                                    Spacer()
                                    
                                    // 뷰모델 별점
                                    HStack {
                                        ForEach(1..<6) { index in
                                            Image(systemName: "star.fill")
                                                .foregroundColor(index <= Int(review.rating) ? .customPink : .customGray1)
                                                .frame(width: 15, height: 15)
                                        }
                                    }
                                }
                                Text("\(review.createdDate)")
                                    .font(.system(size: 15))
                                    .foregroundColor(.customGray1)
                                    .padding(.bottom, 10)
                            }
                            .background(Color.customGray0)
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMyReview()
        }
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Text("리뷰 이미지")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity / 2, minHeight: 30)
            Text("내용")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity / 2, minHeight: 30)
            Text("평점")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity / 2, minHeight: 30)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color.customred)
    }
}

#Preview {
    MyPageView(myPageSelectedTab: .myReview)
}
