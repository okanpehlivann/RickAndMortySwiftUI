import Foundation
import Observation
import SwiftData

@Observable
class FavoritesViewModel {
    func deleteFavorite(favorite: FavoriteCharacter, context: ModelContext) {
        context.delete(favorite)
        
        do {
            try context.save()
        } catch {
            print("Favori silinemedi: \(error.localizedDescription)")
        }
    }
}
