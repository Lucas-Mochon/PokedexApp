import Foundation

enum PokeAPIError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case decoding(Error)
    case network(Error)
}
