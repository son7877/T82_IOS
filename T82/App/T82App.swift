import SwiftUI

@main
struct T82App: App {
    @StateObject private var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .onOpenURL { url in
                    handleURL(url)
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


