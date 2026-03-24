import Foundation
import Observation
import SwiftData

@Observable
class ProfileViewModel {
    var authManager = AuthManager.shared
    
    var username: String {
        AuthManager.shared.currentUser?.username ?? "Misafir"
    }
    
    func logout() {
        AuthManager.shared.logout()
    }
    
    func clearAllFavorites(context: ModelContext, favorites: [FavoriteCharacter]) {
        for favorite in favorites {
            context.delete(favorite)
        }
        
        try? context.save()
    }
}
