import SwiftUI
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct T82App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var viewRouter = ViewRouter()
    
    init(){
        KakaoSDK.initSDK(appKey: "7482ff10ddcc2f9b977ca52de9dd4052")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .onOpenURL { url in
                    handleURL(url)
                    GIDSignIn.sharedInstance.handle(url)
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
    
    private func handleURL(_ url: URL) {
        let pathComponents = url.pathComponents
        if pathComponents.count > 1 {
            let viewName = pathComponents[1]
            viewRouter.currentPage = viewName
        }
    }
}
