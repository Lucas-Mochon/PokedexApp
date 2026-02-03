import SwiftUI
import Combine

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    @State private var pokemonImages: [Int: String] = [:]
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pokédex")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color.pokemonBackground)
                
                TextField("Rechercher un Pokémon...", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                
                if viewModel.pokemonList.isEmpty && !viewModel.isLoading {
                    VStack {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("Aucun Pokémon trouvé")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.pokemonBackground)
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 160), spacing: 12)],
                            spacing: 12
                        ) {
                            ForEach(viewModel.pokemonList) { pokemon in
                                NavigationLink(value: pokemon) {
                                    PokemonCard(
                                        pokemon: pokemon,
                                        imageURL: pokemonImages[pokemon.id]
                                    )
                                }
                                .onAppear {
                                    Task {
                                        await loadPokemonImage(for: pokemon)
                                    }
                                    
                                    if pokemon.id == viewModel.pokemonList.last?.id {
                                        Task {
                                            await viewModel.loadMorePokemon()
                                        }
                                    }
                                }
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .gridCellUnsizedAxes(.horizontal)
                            }
                        }
                        .padding(12)
                    }
                    .background(Color.pokemonBackground)
                }
                
                if let error = viewModel.errorMessage {
                    VStack(spacing: 8) {
                        Image(systemName: "exclamationmark.circle")
                            .font(.headline)
                        Text(error)
                            .font(.caption)
                    }
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.red.opacity(0.1))
                }
            }
            .navigationDestination(for: PokemonListItem.self) { pokemon in
                PokemonDetailView(pokemonId: pokemon.id)
            }
            .task {
                await viewModel.loadInitialPokemon()
            }
        } detail: {
            VStack(spacing: 16) {
                Image(systemName: "circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                Text("Sélectionnez un Pokémon")
                    .font(.headline)
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pokemonBackground)
        }
    }
    
    private func loadPokemonImage(for pokemon: PokemonListItem) async {
        guard pokemonImages[pokemon.id] == nil else { return }
        
        do {
            let fullPokemon = try await PokeAPIService.shared.fetchPokemon(id: pokemon.id)
            
            if let imageURL = fullPokemon.sprites.frontDefault {
                await MainActor.run {
                    pokemonImages[pokemon.id] = imageURL
                }
            } else {
                print("Pas d'image pour \(pokemon.name)")
            }
        } catch {
            print("Erreur: \(error)")
        }
    }
}

#Preview {
    PokemonListView()
}
