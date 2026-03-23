import SwiftUI
import SwiftData

struct FavoritesView: View {
    @State private var viewModel = FavoritesViewModel()
    @Query(sort: \FavoriteCharacter.dateAdded, order: .reverse)
    private var favoriteCharacters: [FavoriteCharacter]
    @Environment(\.modelContext) private var modelContext
    
    private let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                darkNavy.ignoresSafeArea()
                
                if favoriteCharacters.isEmpty {
                    ContentUnavailableView("Favori Yok", systemImage: "heart.slash", description: Text("Henüz hiç karakter favorilemedin."))
                        .preferredColorScheme(.dark)
                } else {
                    List {
                        ForEach(favoriteCharacters) { favorite in
                            Text(favorite.name)
                                .foregroundColor(.white)
                                .listRowBackground(Color.white.opacity(0.05))
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel.deleteFavorite(favorite: favorite, context: modelContext)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Favoriler")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(darkNavy, for: .navigationBar)
        }
    }
}
