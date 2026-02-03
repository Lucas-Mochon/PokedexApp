import SwiftUI
import Combine

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentOffset = 0
    private let itemsPerPage = 20
    private var hasMorePages = true
    
    private let service = PokeAPIService.shared
    
    func loadInitialPokemon() async {
        currentOffset = 0
        hasMorePages = true
        pokemonList = []
        await loadMorePokemon()
    }
    
    func loadMorePokemon() async {
        guard !isLoading && hasMorePages else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchPokemonList(
                limit: itemsPerPage,
                offset: currentOffset
            )
            
            pokemonList.append(contentsOf: response.results)
            currentOffset += itemsPerPage
            hasMorePages = response.next != nil
            
        } catch {
            errorMessage = "Erreur lors du chargement: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

