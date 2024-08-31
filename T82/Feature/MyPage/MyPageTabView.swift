import SwiftUI

struct MyPageTabView : View{
    
    var selection : MyPageTabInfo
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            switch selection{
                case .myInfoEditing:
                    MyInfoEditingView()
                case .myTicket:
                    MyTicketView()
                case .myReview:
                    MyReviewView()
                case .myfavorite:
                    MyFavoriteView()
            }
        }
    }
}
