import SwiftUI

struct PokemonImageView: View {
    let imageURL: String?
    let size: CGFloat
    
    var body: some View {
        if let imageURL = imageURL, !imageURL.isEmpty {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: size, height: size)
                        .background(Color.pokemonBackground)
                        .cornerRadius(12)
                
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .background(Color.pokemonBackground)
                        .cornerRadius(12)
                
                case .failure:
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                        .frame(width: size, height: size)
                        .background(Color.pokemonBackground)
                        .cornerRadius(12)
                
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 40))
                .foregroundColor(.gray)
                .frame(width: size, height: size)
                .background(Color.pokemonBackground)
                .cornerRadius(12)
        }
    }
}
