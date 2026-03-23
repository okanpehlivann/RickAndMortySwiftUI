import SwiftUI

@main
struct RickAndMortApp: App {
    @State private var auth = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
