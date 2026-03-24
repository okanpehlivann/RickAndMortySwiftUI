import Foundation
import Observation

@Observable
class LoginViewModel {
    var username = ""
    var password = ""
    
    func performLogin() {
        if !username.isEmpty && !password.isEmpty {
            guard !username.isEmpty else { return }
            AuthManager.shared.login(username: username)
        }
    }
}
