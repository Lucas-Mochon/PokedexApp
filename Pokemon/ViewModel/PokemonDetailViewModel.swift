import SwiftUI
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = PokeAPIService.shared
    
    func loadPokemon(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            pokemon = try await service.fetchPokemon(id: id)
        } catch {
            errorMessage = "Impossible de charger le Pokémon"
        }
        
        isLoading = false
    }
}
