import Foundation

extension String {
    func formattedPhoneNumber() -> String {
        
        // 숫자만 남기기
        let digits = self.filter { $0.isNumber }
        
        var formatted = ""
        var index = digits.startIndex
        
        // 010-XXXX-XXXX 형식으로 포맷팅
        if digits.count >= 3 {
            let firstPart = digits[index..<digits.index(index, offsetBy: 3)]
            formatted += firstPart
            if digits.count > 3 {
                formatted += "-"
            }
            index = digits.index(index, offsetBy: 3)
        }
        
        if digits.count >= 7 {
            let secondPart = digits[index..<digits.index(index, offsetBy: 4)]
            formatted += secondPart
            if digits.count > 7 {
                formatted += "-"
            }
            index = digits.index(index, offsetBy: 4)
        }
        
        let remaining = digits[index...]
        formatted += remaining
        
        return formatted
    }
}
