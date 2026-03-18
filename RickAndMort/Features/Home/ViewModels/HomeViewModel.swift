//
//  HomeViewModel.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    var characters: [Character] = []
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/character"
    var isLoading = false
    
    func fetchCharacters() async {
        guard let urlString = nextPageURL, let url = URL(string: urlString), !isLoading else { return }
        
        isLoading = true
        do {
            let response: CharacterResponse = try await NetworkManager.shared.fetch(url: url)
            self.characters.append(contentsOf: response.results)
            self.nextPageURL = response.info.next
        } catch {
            print("Hata: \(error)")
        }
        isLoading = false
    }
}
