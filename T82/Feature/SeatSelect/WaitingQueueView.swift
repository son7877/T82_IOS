import SwiftUI
import WebKit

struct WaitingQueueView: View {
    
    var htmlContent: String
    @Binding var isPresented: Bool
    @State private var webView: WKWebView?
    @ObservedObject var viewModel: SeatsViewModel
    var eventId: Int
    
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            VStack {
                // 새로 고침 버튼
                Button(action: {
                    reloadWebViewContent()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                .padding()
            }
            .padding()
            
            WebView(
                htmlContent: htmlContent,
                webViewHandler: { webView in
                    self.webView = webView
                }
            )
        }
        .onAppear {
            startStatusCheckTimer()
        }
        .onDisappear {
            stopStatusCheckTimer()
            isPresented = false
        }
    }
    
    private func startStatusCheckTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            viewModel.checkWaitingQueueStatus(eventId: eventId)
            reloadWebViewContent()
        }
    }
    
    private func stopStatusCheckTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func reloadWebViewContent() {
        viewModel.getWaitingQueue(eventId: eventId) // HTML 내용 업데이트
        if let webView = webView {
            webView.loadHTMLString(viewModel.htmlContent, baseURL: nil) // 웹뷰 내용 새로 고침
        }
    }
}
