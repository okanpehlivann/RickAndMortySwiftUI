//
//  HomeView.swift
//  RickAndMort
//
//  Created by Okan on 18.03.2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                darkNavy.ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.characters) { character in
                            CharacterCard(character: character)
                                .onAppear {
                                    if character.id == viewModel.characters.last?.id {
                                        Task { await viewModel.fetchCharacters() }
                                    }
                                }
                        }
                        
                        if viewModel.isLoading {
                            ProgressView().tint(.cyan)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Karakterler")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(darkNavy, for: .navigationBar)
        }
        .task {
            await viewModel.fetchCharacters()
        }
    }
}

#Preview {
    HomeView()
}
