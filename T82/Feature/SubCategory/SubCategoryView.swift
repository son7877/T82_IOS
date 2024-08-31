import SwiftUI

struct SubCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    @StateObject var viewModel: SubCategoryViewModel
    @State private var selectedSubCategory: SubCategory

    init(title: String, viewModel: SubCategoryViewModel) {
        self.title = title
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._selectedSubCategory = State(initialValue: viewModel.subCategory)
    }

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                isDisplayLeftBtn: true,
                isDisplayRightBtn: true,
                isDisplayTitle: true,
                leftBtnAction: {
                    presentationMode.wrappedValue.dismiss()
                },
                rightBtnAction: {},
                lefttBtnType: .back,
                rightBtnType: .search,
                Title: title
            )
            .padding()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {

                    // 하위 장르별 랭킹
                    Text("장르별 랭킹")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    // 세부 카테고리 선택 버튼들
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.genre.subCategories) { subCategory in
                                Button(action: {
                                    selectedSubCategory = subCategory
                                    viewModel.fetchSubCategoryEvents(subCategory: subCategory)
                                }) {
                                    Text(subCategory.name)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 12)
                                        .background(selectedSubCategory == subCategory ? Color.customred : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    if viewModel.subCategoryEvents.isEmpty {
                        Text("Coming Soon..")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding(.vertical, 84)
                            .padding(.horizontal, 50)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.subCategoryEvents) { event in
                                    NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.id))) {
                                        VStack {
                                            AsyncImage(url: URL(string: event.imageUrl)) {
                                                image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 100, height: 150)
                                            
                                            Text(event.title)
                                                .font(.caption)
                                                .frame(width: 100)
                                                .foregroundColor(.black)
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                }
                            }
                            .padding()
                        }
                    }

                    // 오픈 예정
                    Text("OPEN SOON")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if viewModel.openSoonEvents.isEmpty {
                        Text("Coming Soon..")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding(.vertical, 84)
                            .padding(.horizontal, 50)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.openSoonEvents) { event in
                                    NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.id))) {
                                        VStack {
                                            AsyncImage(url: URL(string: event.imageUrl)) {
                                                image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 100, height: 150)
                                            
                                            Text(event.title)
                                                .font(.caption)
                                                .frame(width: 100)
                                                .foregroundColor(.black)
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchSubCategoryEvents(subCategory: selectedSubCategory)
            viewModel.fetchOpenSoonEvents()
        }
    }
}

