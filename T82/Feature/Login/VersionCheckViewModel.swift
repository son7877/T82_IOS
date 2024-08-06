import Foundation
import Combine

class VersionCheckViewModel: ObservableObject {
    @Published var shouldShowUpdateAlert: Bool? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func checkForUpdate() {
        guard let currentBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return
        }
        
        let versionRequest = CheckVersion(appId: Config().appId, currentVersion: currentBuildNumber)
        
        VersionService.shared.checkForUpdate(versionRequest: versionRequest) { result in
            switch result {
            case .success(let shouldUpdate):
                DispatchQueue.main.async {
                    self.shouldShowUpdateAlert = shouldUpdate
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.shouldShowUpdateAlert = nil
                }
            }
        }
    }
}
