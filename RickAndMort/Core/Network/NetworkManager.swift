//
//  NetworkManager.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetch<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
