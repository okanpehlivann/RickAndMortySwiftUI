import Foundation
import Observation

@Observable
class AuthManager {
    static let shared = AuthManager()
    
    var currentUser: User?
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    private init() {}
    
    func login(username: String) {
        self.currentUser = User(username: username, email: "\(username)@rickandmorty.com")
    }
    
    func logout() {
        self.currentUser = nil
    }
}
