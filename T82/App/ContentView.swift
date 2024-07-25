import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            switch viewRouter.currentPage {
            case "login":
                LoginView()
            case "main":
                MainView()
            case "paymentSuccess":
                PaymentCompleteView()
            case "myPage/myticket":
                MyPageView(myPageSelectedTab: .myTicket)
            case "myPage/infoEdit":
                MyPageView(myPageSelectedTab: .myInfoEditing)
            default:
                Text("404 NOT FOUND")
            }
        }
    }
}
