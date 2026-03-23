import SwiftUI
import SwiftData

@main
struct RickAndMortApp: App {
    @State private var auth = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                MainTabView()
                   
            } else {
                LoginView()
            }
        }
        .modelContainer(for: FavoriteCharacter.self)
    }
}
