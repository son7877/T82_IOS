import Foundation

class MyInfoEditingViewModel: ObservableObject {
    @Published var user: User
    
    init(user:User = User(
        email: "",
        password: "",
        passwordCheck: "",
        nickName: "",
        birthday: Date(),
        phoneNum: "",
        address: "",
        addressDetail: "")) {
        self.user = user
    }
}
