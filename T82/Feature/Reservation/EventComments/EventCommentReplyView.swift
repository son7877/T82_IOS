import SwiftUI

struct EventCommentReplyView: View {
    
    let eventInfoId: Int
    let reviewId: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var eventCommentViewModel = EventCommentViewModel()
    @State private var replyContent: String = ""
    
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
                Title: "답글 (\(eventCommentViewModel.replies.count))"
            )
            .padding()
            Divider()
            
            if eventCommentViewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                ScrollView {
                    // 부모 댓글
                    if let parentReview = eventCommentViewModel.eventInfoReviews.first(where: { $0.reviewId == reviewId }) {
                        VStack(alignment: .leading) {
                            HStack {
                                if let url = URL(string: parentReview.userImage ?? "") {
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
                                    Text(parentReview.userName)
                                        .font(.headline)
                                    Text(parentReview.createdDate)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            Text(parentReview.content)
                                .font(.body)
                                .padding(.top, 5)
                            
                            HStack {
                                Image(systemName: "bubble.left.and.text.bubble.right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.gray)
                                Text("답글 \(eventCommentViewModel.replies.count)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 5)
                        }
                        .padding()
                        
                        Divider()
                    }
                    
                    ForEach(eventCommentViewModel.replies) { reply in
                        ReplyRow(reply: reply)
                        Divider()
                    }
                }
            }
            
            Divider()
                
            // 답글 작성
            HStack {
                TextField("답글을 입력해주세요.", text: $replyContent)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .tint(.customred)
                Button(action: {
                    eventCommentViewModel.addReplies(reviewId: reviewId, content: replyContent)
                    replyContent = ""
                }) {
                    Text("등록")
                        .foregroundColor(.customred)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            eventCommentViewModel.fetchEventInfoReviews(eventInfoId: eventInfoId)
            eventCommentViewModel.fetchReplies(reviewId: reviewId)
        }
    }
}

struct ReplyRow: View {
    
    let reply: Replies
    @StateObject var eventCommentViewModel = EventCommentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "arrow.turn.down.right")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                if let url = URL(string: reply.userImage ?? "") {
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
                    HStack{
                        Text(reply.username)
                            .font(.headline)
                        if reply.isArtist {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.gray)
                        }
                    }
                    Text("\(dateFormating(date: reply.createdDate))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            Text(reply.content)
                .font(.body)
                .padding(.top, 5)
                .padding(.horizontal, 25)
        }
        .padding()
    }
    
    private func dateFormating(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date ?? Date())
    }
}

