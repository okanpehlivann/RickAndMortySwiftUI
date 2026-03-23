import Foundation
import Observation
import Combine

@Observable
class HomeViewModel {
    var characters: [Character] = []
    private var nextPageURL: String? = nil
    var isLoading = false
    var isInitialLoading = true
    
    var searchText: String = ""
    var selectedStatus: CharacterStatus? = nil
    var selectedGender: CharacterGender? = nil
    
    private var searchTask: Task<Void, Never>? = nil
    
    func onSearchTextChanged() {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            guard !Task.isCancelled else { return }
            await resetAndFetch()
        }
    }
    
    func resetAndFetch() async {
        characters = []
        nextPageURL = nil
        isInitialLoading = true
        await fetchCharacters()
    }
    
    func fetchCharacters() async {
        guard !isLoading && (nextPageURL != nil || isInitialLoading) else { return }
        isLoading = true
        
        var urlString = nextPageURL ?? "https://rickandmortyapi.com/api/character"
        var queryItems: [String] = []
        
        if nextPageURL == nil {
            if !searchText.isEmpty { queryItems.append("name=\(searchText.trimmingCharacters(in: .whitespacesAndNewlines))") }
            if let status = selectedStatus { queryItems.append("status=\(status.rawValue)") }
            if let gender = selectedGender { queryItems.append("gender=\(gender.rawValue)") }
            
            if !queryItems.isEmpty {
                urlString += "/?\(queryItems.joined(separator: "&"))"
            }
        }
        
        do {
            let response: CharacterResponse = try await NetworkManager.shared.fetch(url: URL(string: urlString)!)
            
            await MainActor.run {
                self.characters.append(contentsOf: response.results)
                self.nextPageURL = response.info.next
                self.isLoading = false
                self.isInitialLoading = false
            }
        } catch {
            print("API Hatası: \(error)")
            await MainActor.run {
                self.isLoading = false
                self.isInitialLoading = false
                self.characters = []
            }
        }
    }
}
