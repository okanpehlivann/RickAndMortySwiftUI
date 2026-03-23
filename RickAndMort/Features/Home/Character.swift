import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

enum CharacterStatus: String, Codable, CaseIterable, Identifiable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var id: String { self.rawValue }
    
    var colorName: String {
        switch self {
            case .alive: return "green"
            case .dead: return "red"
            case .unknown: return "gray"
        }
    }
}

enum CharacterGender: String, Codable, CaseIterable, Identifiable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    var id: String { self.rawValue }
}

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let next: String?
}
