import SwiftUI
import Kingfisher
import SwiftData

struct CharacterDetailView: View {
    @State private var viewModel = CharacterDetailViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteCharacter]
    
    let characterId: Int
    
    private let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
        
    var body: some View {
        ZStack {
            darkNavy.ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView().tint(.cyan)
            } else if let character = viewModel.character {
                renderDetailContent(character)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.toggleFavorite(context: modelContext, favorites: favorites)
                } label: {
                    Image(systemName: viewModel.isFavorite(id: characterId, favorites: favorites) ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite(id: characterId, favorites: favorites) ? .red : .white)
                }
            }
        }
        .task {
            await viewModel.getCharacterDetail(id: characterId)
        }
    }
    
    @ViewBuilder
    private func renderDetailContent(_ character: CharacterDetail) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    
                    KFImage(URL(string: character.image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height + (minY > 0 ? minY : 0))
                        .clipped()
                        .offset(y: minY > 0 ? -minY : 0)
                }
                .frame(height: 350)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(character.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack {
                            Circle()
                                .fill(character.status == "Alive" ? .green : (character.status == "Dead" ? .red : .gray))
                                .frame(width: 10, height: 10)
                            Text("\(character.species) • \(character.status)")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 25)
                    
                    VStack(spacing: 12) {
                        InfoRow(title: "Gender", value: character.gender, icon: "person.fill")
                        InfoRow(title: "Origin", value: character.origin.name, icon: "globe")
                        InfoRow(title: "Location", value: character.location.name, icon: "mappin.and.ellipse")
                        InfoRow(title: "Episodes", value: "\(character.episode.count) Episodes", icon: "tv.fill")
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.horizontal)
                .background(darkNavy)
                .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                .offset(y: -30)
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
