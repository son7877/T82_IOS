import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView{
            VStack {
                switch viewRouter.currentPage {
                case "login":
                    LoginView()
                case "main":
                    MainView(selectedIndex: 4)
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
}
