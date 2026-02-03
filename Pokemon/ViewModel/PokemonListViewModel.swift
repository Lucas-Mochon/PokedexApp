import SwiftUI
import Combine

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var searchText: String = ""
    
    private var currentOffset = 0
    private let itemsPerPage = 20
    private var hasMorePages = true
    
    private let service = PokeAPIService.shared
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                Task { await self?.performSearch(text: text) }
            }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadInitialPokemon() async {
        currentOffset = 0
        hasMorePages = true
        pokemonList = []
        await loadMorePokemon()
    }
    
    func loadMorePokemon() async {
        guard !isLoading && hasMorePages && searchText.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchPokemonList(limit: itemsPerPage, offset: currentOffset)
            pokemonList.append(contentsOf: response.results)
            currentOffset += itemsPerPage
            hasMorePages = response.next != nil
        } catch {
            errorMessage = "Erreur lors du chargement: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func performSearch(text: String) async {
        if text.isEmpty {
            await loadInitialPokemon()
        } else {
            await searchPokemon(by: text)
        }
    }
    
    func searchPokemon(by name: String) async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchPokemonList(limit: 10000)
            let filtered = response.results.filter { $0.name.lowercased().contains(name.lowercased()) }
            pokemonList = filtered
            hasMorePages = false
        } catch {
            errorMessage = "Erreur lors du chargement: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
