import SwiftUI
import SwiftData

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteCharacter]
    @State private var showDeleteConfirmation = false
    
    private let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                darkNavy.ignoresSafeArea()
                
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.cyan)
                        
                        Text(viewModel.username)
                            .font(.title.bold())
                            .foregroundColor(.white)
                    }
                    .padding(.top, 40)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("\(favorites.count)")
                                .font(.title2.bold())
                                .foregroundColor(.cyan)
                            Text("Favoriler")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack {
                        Button(role: .destructive, action: {
                            showDeleteConfirmation = true
                        }) {
                            HStack {
                                Image(systemName: "heart.slash.fill")
                                Text("Tüm Favorileri Temizle")
                            }
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.red.opacity(0.5), lineWidth: 1)
                            )
                        }
                        .disabled(favorites.isEmpty) // Favori yoksa butonu deaktif yap
                        .opacity(favorites.isEmpty ? 0.5 : 1.0)
                        
                        Button(action: {
                            viewModel.logout()
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Çıkış Yap")
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.bottom, 30)
                    .padding(.horizontal)
                    
                }
            }
            .navigationTitle("Profil")
            .confirmationDialog(
                "Emin misiniz?",
                isPresented: $showDeleteConfirmation,
                titleVisibility: .visible
            ) {
                Button("Tümünü Sil", role: .destructive) {
                    viewModel.clearAllFavorites(context: modelContext, favorites: favorites)
                }
                Button("Vazgeç", role: .cancel) { }
            } message: {
                Text("Tüm favori karakterleriniz kalıcı olarak silinecektir. Bu işlem geri alınamaz.")
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
