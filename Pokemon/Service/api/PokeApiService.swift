import Foundation

final class PokeAPIService {

    static let shared = PokeAPIService()
    private init() {}

    private let scheme = "https"
    private let host = "pokeapi.co"
    private let basePath = "/api/v2"

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func request<T: Decodable>(_ endpoint: PokeEndpoint) async throws -> T {
        guard let url = makeURL(from: endpoint) else {
            throw PokeAPIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw PokeAPIError.invalidResponse(statusCode: -1)
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw PokeAPIError.invalidResponse(statusCode: httpResponse.statusCode)
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw PokeAPIError.decoding(error)
            }

        } catch {
            throw PokeAPIError.network(error)
        }
    }

    private func makeURL(from endpoint: PokeEndpoint) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + endpoint.path
        components.queryItems = endpoint.queryItems

        return components.url
    }
}
