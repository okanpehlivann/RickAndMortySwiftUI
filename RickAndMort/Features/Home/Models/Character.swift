//
//  Character.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let next: String?
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}
