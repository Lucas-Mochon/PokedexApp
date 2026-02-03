import Foundation

enum PokeEndpoint {
    case pokemonList(limit: Int, offset: Int)
    case pokemonById(Int)
    case pokemonByName(String)

    var path: String {
        switch self {
        case .pokemonList:
            return "/pokemon"
        case .pokemonById(let id):
            return "/pokemon/\(id)"
        case .pokemonByName(let name):
            return "/pokemon/\(name.lowercased())"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .pokemonList(let limit, let offset):
            return [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
        default:
            return nil
        }
    }
}
