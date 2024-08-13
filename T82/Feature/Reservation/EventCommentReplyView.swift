import SwiftUI

struct EventCommentReplyView: View {
    
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
                Title: "답글 (갯수)"
            )
            .padding()
            Divider()
            
            Spacer()
            
            ScrollView {
                
                // 부모 댓글
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
                    
                    HStack {
                        Image(systemName: "bubble.left.and.text.bubble.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                        Text("답글 1")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 5)
                }
                .padding()
                
                Divider()
                
                ForEach(0..<5) { _ in
                    ReplyRow()
                    Divider()
                }
            }
            
            Divider()
                
            // 답글 작성
            HStack {
                TextField("답글을 입력해주세요.", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .tint(.customred)
                Button(action: {
                    
                }) {
                    Text("등록")
                        .foregroundColor(.customred)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ReplyRow: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "arrow.turn.down.right")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
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
            Text("답글 내용")
                .font(.body)
                .padding(.top, 5)
                .padding(.horizontal, 25)
        }
        .padding()
    }
}

#Preview {
    EventCommentReplyView()
}
