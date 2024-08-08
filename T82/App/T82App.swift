import SwiftUI
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct T82App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var viewRouter = ViewRouter()
    
    init(){
        KakaoSDK.initSDK(appKey: Config().kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .onOpenURL { url in
                    handleURL(url)
                    let _ = delegate.application(UIApplication.shared, open: url, options: [:])
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
