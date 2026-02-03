extension PokeAPIService {

    func fetchPokemonList(limit: Int = 20,offset: Int = 0) async throws -> PokemonListResponse {
        try await request(.pokemonList(limit: limit, offset: offset))
    }

    func fetchPokemon(id: Int) async throws -> Pokemon {
        try await request(.pokemonById(id))
    }

    func fetchPokemon(name: String) async throws -> Pokemon {
        try await request(.pokemonByName(name))
    }
}
