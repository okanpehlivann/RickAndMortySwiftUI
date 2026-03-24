import Foundation

struct CharacterDetail: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationInfo
    let location: LocationInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    static func == (lhs: CharacterDetail, rhs: CharacterDetail) -> Bool {
        lhs.id == rhs.id
    }
}

struct LocationInfo: Codable {
    let name: String
    let url: String
}
