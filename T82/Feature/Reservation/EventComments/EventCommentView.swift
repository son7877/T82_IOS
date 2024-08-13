import SwiftUI

struct EventCommentView: View {
    
    let eventInfoId: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var eventCommentViewModel = EventCommentViewModel()
    
    var body: some View {
        VStack{
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: false,
                isDisplayTitle: true,
                leftBtnAction: {
                    presentationMode.wrappedValue.dismiss()
                },
                rightBtnAction: {
                    
                },
                lefttBtnType: .back,
                rightBtnType: .back,
                Title: "댓글 (\(eventCommentViewModel.eventInfoReviews.count))"
            )
            .padding()
            Divider()
            
            if eventCommentViewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                ScrollView {
                    VStack {
                        ForEach(eventCommentViewModel.eventInfoReviews) { review in
                            CommentRow(review: review)
                            Divider()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            eventCommentViewModel.fetchEventInfoReviews(eventInfoId: eventInfoId)
        }
    }
}

struct CommentRow: View {
    
    let review: EventInfoReviews
    @StateObject var eventCommentViewModel = EventCommentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let url = URL(string: review.userImage ?? "") {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                    }
                }
                VStack(alignment: .leading) {
                    Text(review.username)
                        .font(.headline)
                    Text(review.createDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            Text(review.content)
                .font(.body)
                .padding(.top, 5)
            
            // 대댓글 이동
            NavigationLink(destination: EventCommentReplyView(reviewId: review.reviewId)) {
                HStack {
                    Image(systemName: "bubble.left.and.text.bubble.right")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundColor(.gray)
                    Text("답글 개수 \(eventCommentViewModel.replies.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 5)
        }
        .padding()
    }
}

#Preview {
    EventCommentView(eventInfoId: 1)
}
