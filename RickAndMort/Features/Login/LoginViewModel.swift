import Foundation
import Observation

@Observable
class LoginViewModel {
    var username = ""
    var password = ""
    
    func performLogin() {
        if !username.isEmpty && !password.isEmpty {
            AuthManager.shared.login()
        }
    }
}
