import SwiftUI

struct SubCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    @StateObject var viewModel: SubCategoryViewModel

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
                if viewModel.subCategoryEvents.isEmpty {
                    Text("404 SubCategory Ranking Not Found")
                        .padding()
                } else {
                    TabView {
                        ForEach(viewModel.subCategoryEvents) { event in
                            VStack(alignment: .leading) {
                                Image("sampleImg")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width, height: 350)
                            }
                            .padding(.vertical, 0)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 200)
                    .padding(.bottom, 20)
                }
                
                // 하위 장르별 랭킹
                VStack(alignment: .leading) {
                    Text("장르별 랭킹")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.subCategoryEvents) { event in
                                NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.id))) {
                                    VStack {
                                        Image("sampleImg")
                                            .resizable()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                        
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
                VStack(alignment: .leading) {
                    Text("OPEN SOON")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.subCategoryEvents) { event in
                                NavigationLink(destination: ReservationView(viewModel: ReservationViewModel(eventInfoId: event.id))) {
                                    VStack {
                                        Image("sampleImg")
                                            .resizable()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                        
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
        .navigationBarBackButtonHidden()
    }
}

#Preview{
    MainpageView()
}
