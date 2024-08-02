import Foundation
import Alamofire
import UIKit
import SwiftUI
import naveridlogin_ios_sp

struct NaverLoginRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NaverLoginRepresentable>) -> NaverLoginViewController {
       let naverLoginViewController = NaverLoginViewController()

        return naverLoginViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

}

class NaverLoginViewController: UIViewController {

    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naverLoginInstance?.delegate = self
        self.naverLoginInstance?.requestThirdPartyLogin()
    }
}


extension NaverLoginViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인 성공시 메소드 (추가적인 API 통신을 진행하여 정보를 가져옴)
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
    }
    
    // 토큰을 재 갱신하는경우 메소드
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("Success RefreshToken")
    }
    
    // 로그아웃 (토큰 삭제) 완료시 메소드
    func oauth20ConnectionDidFinishDeleteToken() {
        print("Success logout")
        naverLoginInstance?.requestDeleteToken()
    }
    
    // 모든 에러관련한 메소드
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
        naverLoginInstance?.requestDeleteToken()
    }
    
    func getNaverUserInfo() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }

        if !isValidAccessToken {
            return
        }

        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        guard let refreshToken = naverLoginInstance?.refreshToken else { return }

        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!

        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":  "\(tokenType) \(accessToken)"])

        request.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else {return}
        }
    }
}


