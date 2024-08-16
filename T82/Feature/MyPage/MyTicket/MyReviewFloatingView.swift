import SwiftUI
import PopupView

struct MyReviewFloatingView: View {
    
    @ObservedObject var myTicketViewModel: MyTicketViewModel
    @ObservedObject var reviewViewModel: MyReviewViewModel
    @Binding var isPresented: Bool
    @State private var rating: Int = 0
    @State private var createdDate: String = ""
    @State private var reviewText: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var showCompleteAlert: Bool = false
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var eventInfoId: Int

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("리뷰 등록")
                    .font(.headline)
                    .padding(.vertical, 5)
                Spacer()
            }
            .padding(.horizontal)
            
            // 별점 등록
            HStack {
                ForEach(1..<6) { index in
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
            
            // 리뷰 이미지 등록
            HStack{
                Text("리뷰 이미지 등록")
                    .font(.headline)
                    .padding()
                
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .cornerRadius(15)
                    } else {
                        Text("이미지 선택")
                            .frame(width: 70, height: 70)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Button(action: {
                let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
                
                reviewViewModel.addReview(reviewRequest: MyReviewRequest(
                    eventInfoId: eventInfoId,
                    content: reviewText,
                    rating: Double(rating),
                    reviewPictureUrl: nil),
                    imageData: imageData)
                
                if reviewViewModel.reviewSubmissionSuccess {
                    showCompleteAlert = true
                    isPresented = false
                } else {
                    showErrorAlert = true
                }
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
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("리뷰 등록 실패"),
                message: Text("\(reviewViewModel.reviewSubmissionError)"),
                dismissButton: .default(Text("확인"))
            )
        }
        .alert(isPresented: $showCompleteAlert) {
            Alert(
                title: Text("리뷰 등록 완료"),
                message: Text("리뷰 등록이 완료되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isPickerPresented: $isImagePickerPresented)
        }
    }
}
