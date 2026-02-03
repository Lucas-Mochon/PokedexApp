import SwiftUI

struct PokemonCard: View {
    let pokemon: PokemonListItem
    let imageURL: String?
    
    var body: some View {
        VStack(spacing: 12) {
            PokemonImageView(imageURL: imageURL, size: 120)
            
            VStack(spacing: 4) {
                Text("#\(pokemon.id)")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                
                Text(pokemon.name.capitalized)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .padding(12)
        .background(Color.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}
