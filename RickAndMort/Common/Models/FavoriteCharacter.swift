import Foundation
import SwiftData

@Model
final class FavoriteCharacter {
    @Attribute(.unique) var id: Int // aynı karakterin iki kez eklenmesini önler
    var name: String
    var status: String
    var species: String
    var image: String
    var dateAdded: Date
    
    init(id: Int, name: String, status: String, species: String, image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.image = image
        self.dateAdded = Date()
    }
}
