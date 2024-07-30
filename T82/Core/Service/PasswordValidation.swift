import Foundation

struct Validation {
    
    static func validatePassword(_ password: String) -> String {
        if password.count < 8 {
            return "비밀번호는 최소 8자 이상이어야 합니다."
        }
        else if !password.contains(where: { $0.isLetter }) {
            return "비밀번호는 하나 이상의 문자를 포함해야 합니다."
        }
        else if !password.contains(where: { $0.isNumber }) {
            return "비밀번호는 하나 이상의 숫자를 포함해야 합니다."
        }
        else if !password.contains(where: { $0 == "!" || $0 == "@" || $0 == "#" || $0 == "$" || $0 == "%" || $0 == "^" || $0 == "&"}) {
            return "비밀번호는 하나 이상의 특수문자(!,@,#,$,%,^,&)를 포함해야 합니다."
        } else {
            return ""
        }
    }
    
    static func validatePasswordCheck(password: String, passwordCheck: String) -> String {
        if password != passwordCheck {
            return "비밀번호가 일치하지 않습니다."
        }else{
            return ""
        }
    }
}
