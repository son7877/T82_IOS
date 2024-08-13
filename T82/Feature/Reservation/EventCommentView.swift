import SwiftUI

struct EventCommentView: View {
    
    let eventInfoId: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                Title: "댓글 (갯수)"
            )
            .padding()
            Divider()
            
            Spacer()
            
            ScrollView {
                VStack {
                    ForEach(0..<5) { _ in
                        CommentRow()
                        Divider()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CommentRow: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("sampleImg2")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("작성자")
                        .font(.headline)
                    Text("작성일")
                        .font(.subheadline)
                        .foregroundColor(.customgray1)
                }
                Spacer()
            }
            Text("댓글 내용")
                .font(.body)
                .padding(.top, 5)
            
            NavigationLink(destination: EventCommentReplyView()) {
                // 네모 박스 형태
                HStack {
                    Image(systemName: "bubble.left.and.text.bubble.right")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundColor(.gray)
                    Text("답글 1")
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

