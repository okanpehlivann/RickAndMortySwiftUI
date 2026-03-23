import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://rickandmortyapi.com/api"
    
    func fetch<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func fetchCharacters(pageURL: String?) async throws -> CharacterResponse {
        // Eğer sayfa URL'i gelmişse onu kullan (next page), gelmemişse ilk sayfayı oluştur
        let urlString = pageURL ?? "\(baseURL)/character"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        return try await fetch(url: url)
    }
    
    func fetchCharacterDetail(id: Int) async throws -> CharacterDetail {
        let urlString = "\(baseURL)/character/\(id)"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        return try await fetch(url: url)
    }
}
