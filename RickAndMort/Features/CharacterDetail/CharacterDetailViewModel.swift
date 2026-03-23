import Foundation
import Observation

@Observable
class CharacterDetailViewModel {
    var character: CharacterDetail?
    var isLoading = false
    var errorMessage: String?
    
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
