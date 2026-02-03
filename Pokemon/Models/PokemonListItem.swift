struct PokemonListItem: Decodable, Identifiable, Hashable {
    let name: String
    let url: String

    var id: Int {
        Int(url.split(separator: "/").last ?? "0") ?? 0
    }
}
