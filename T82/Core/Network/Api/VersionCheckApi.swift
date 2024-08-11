import Foundation
import Alamofire

class VersionService {
    
    static let shared = VersionService()
    private init() {}
     
    // 업데이트 버전 확인
    func checkForUpdate(versionRequest: CheckVersion, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(Config().VersionCheckHost)/api/v1/version/check"
        
        AF.request(url, method: .post, parameters: versionRequest, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let shouldUpdate = value as? Bool {
                    completion(.success(shouldUpdate))
                } else {
                    completion(.success(false)) // 기본적으로 false 반환
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
