import Foundation

class MyInfoEditingViewModel: ObservableObject {
    @Published var user: User
    @Published var userInfo: UserInfo
    @Published var isEditSuccess = false
    @Published var isDeleteSuccess = false
    @Published var errorMessage: String?
    
    init() {
        self.user = User(email: "", password: "", passwordCheck: "", name: "", birthDate: Date(), phoneNumber: "", address: "", addressDetail: "")
        self.userInfo = UserInfo(name: "", email: "", birthDate: Date(), address: "", addressDetail: "", phoneNumber: "")
    }
    
    // 내 정보 불러오기
    func fetchUserInfo() {
        AuthService.shared.fetchInfo { [weak self] userInfo in
            DispatchQueue.main.async {
                if let userInfo = userInfo {
                    self?.userInfo = userInfo
                    self?.user = User(
                        email: userInfo.email,
                        password: "",
                        passwordCheck: "",
                        name: userInfo.name,
                        birthDate: userInfo.birthDate,
                        phoneNumber: userInfo.phoneNumber,
                        address: userInfo.address,
                        addressDetail: userInfo.addressDetail
                    )
                    print("불러오기 성공: \(userInfo)")
                } else {
                    print("불러오기 실패")
                }
            }
        }
    }
    
    // 내 정보 수정
    func editUserInfo() {
        
        AuthService.shared.updateUserInfo(
            name: user.name,
            password: user.password,
            passwordCheck: user.passwordCheck,
            address: user.address,
            addressDetail: user.addressDetail
        ) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.isEditSuccess = true
                    self?.errorMessage = nil
                    print("회원정보 수정 성공")
                } else {
                    self?.isEditSuccess = false
                    print("회원정보 수정 실패")
                }
            }
        }
    }
    
    // 회원 탈퇴
    func deleteUser() {
        AuthService.shared.deleteUser { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.isDeleteSuccess = true
                    print("회원 탈퇴 성공")
                } else {
                    self?.isDeleteSuccess = false
                    print("회원 탈퇴 실패")
                }
            }
        }
    }
}
