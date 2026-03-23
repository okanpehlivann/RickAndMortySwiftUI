import Foundation
import Observation
import SwiftData

@Observable
class CharacterDetailViewModel {
    var character: CharacterDetail?
    var isLoading = false
    var errorMessage: String?
    
    func isFavorite(id: Int, favorites: [FavoriteCharacter]) -> Bool {
        favorites.contains { $0.id == id }
    }
    
    func toggleFavorite(context: ModelContext, favorites: [FavoriteCharacter]) {
        guard let char = character else { return }
        
        if let existingFavorite = favorites.first(where: { $0.id == char.id }) {
            context.delete(existingFavorite)
        } else {
            let newFavorite = FavoriteCharacter(
                id: char.id,
                name: char.name,
                status: char.status,
                species: char.species,
                image: char.image
            )
            context.insert(newFavorite)
        }
    
        try? context.save()
    }
    
    func getCharacterDetail(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCharacter = try await NetworkManager.shared.fetchCharacterDetail(id: id)
            await MainActor.run {
                self.character = fetchedCharacter
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Karakter yüklenemedi: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
