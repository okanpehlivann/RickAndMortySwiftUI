import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var showFilterSheet = false
    
    let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                darkNavy.ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(destination: CharacterDetailView(characterId: character.id)) {
                                CharacterCard(character: character)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .onAppear {
                                if character.id == viewModel.characters.last?.id && !viewModel.isLoading {
                                    Task { await viewModel.fetchCharacters() }
                                }
                            }
                        }
                        
                        if viewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .tint(.cyan)
                                    .id(UUID())
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Karakterler")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(darkNavy, for: .navigationBar)
            .searchable(text: $viewModel.searchText, prompt: "Karakter Ara...")
            .foregroundColor(.white)
            .onChange(of: viewModel.searchText) { _, _ in
                viewModel.onSearchTextChanged()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showFilterSheet = true }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(viewModel.selectedStatus != nil || viewModel.selectedGender != nil ? .cyan : .white)
                    }
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                Task { await viewModel.resetAndFetch() }
            } content: {
                FilterSheet(
                    title: "Karakter Filtrele",
                    onApply: { Task { await viewModel.resetAndFetch() } },
                    onClear: {
                        viewModel.selectedStatus = nil
                        viewModel.selectedGender = nil
                        Task { await viewModel.resetAndFetch() }
                    }
                ) {
                    // Content kısmına istediğimiz kadar bölüm ekliyoruz
                    FilterSectionView(title: "Durum") {
                        FilterOptionsGrid(options: CharacterStatus.allCases, selectedOption: $viewModel.selectedStatus)
                    }
                    
                    FilterSectionView(title: "Cinsiyet") {
                        FilterOptionsGrid(options: CharacterGender.allCases, selectedOption: $viewModel.selectedGender)
                    }
                    
                    // Yarın başka bir filtre gerekirse buraya eklemek yeterli
                }
                .presentationDetents([.medium, .large])
            }
        }
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    HomeView()
}
