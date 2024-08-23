import SwiftUI
import PopupView

struct MyReviewFloatingView: View {
    
    @ObservedObject var myTicketViewModel: MyTicketViewModel
    @ObservedObject var reviewViewModel: MyReviewViewModel
    @Binding var isPresented: Bool
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var showCompleteAlert: Bool = false
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var eventInfoId: Int

    var body: some View {
        VStack {
            // 제목
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
                .background(Color.white)
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
                            .background(.customGray1.opacity(0.5))
                            .cornerRadius(15)
                            .foregroundColor(.gray)
                            .padding(.bottom,5)
                    }
                }
            }
            
            // 리뷰 등록 버튼
            Button(action: {
                // 상태 초기화
                showErrorAlert = false
                showCompleteAlert = false
                reviewViewModel.reviewSubmissionSuccess = false
                reviewViewModel.reviewSubmissionError = ""

                let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
                
                reviewViewModel.addReview(reviewRequest: MyReviewRequest(
                    eventInfoId: eventInfoId,
                    content: reviewText,
                    rating: Double(rating),
                    reviewPictureUrl: nil),
                    imageData: imageData)
            }, label: {
                Text("등록")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(reviewViewModel.isLoading ? Color.gray : Color.customred)
            })
            .disabled(reviewViewModel.isLoading)  // 등록 중에는 버튼 비활성화
        }
        .background(Color.customGray0)
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
        .onChange(of: reviewViewModel.reviewSubmissionSuccess) { success in
            if success {
                showCompleteAlert = true
                isPresented = false
            } else if !reviewViewModel.reviewSubmissionError.isEmpty {
                showErrorAlert = true
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isPickerPresented: $isImagePickerPresented)
        }
    }
}
