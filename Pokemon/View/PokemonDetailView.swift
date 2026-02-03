import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int
    @StateObject private var viewModel = PokemonDetailViewModel()

    var body: some View {
        Group {
            if let pokemon = viewModel.pokemon {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            PokemonImageView(
                                imageURL: pokemon.sprites.frontDefault,
                                size: 200
                            )
                            
                            VStack(spacing: 8) {
                                Text(pokemon.name.capitalized)
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                
                                Text("#\(String(format: "%04d", pokemon.id))")
                                    .font(.caption)
                                    .foregroundColor(.textSecondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(24)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.1), radius: 8)
                    
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Types")
                                .font(.headline)
                                .foregroundColor(.textPrimary)
                            
                            HStack(spacing: 8) {
                                ForEach(pokemon.types, id: \.slot) { typeEntry in
                                    TypeBadge(type: typeEntry.type.name)
                                }
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Caractéristiques")
                                .font(.headline)
                                .foregroundColor(.textPrimary)
                            
                            HStack(spacing: 16) {
                                StatCard(
                                    label: "Hauteur",
                                    value: "\(pokemon.height / 10)m"
                                )
                                StatCard(
                                    label: "Poids",
                                    value: "\(pokemon.weight / 10)kg"
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(12)
                    }
                    .padding(20)
                }
            }
            else if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.red)
                    
                    Text(viewModel.errorMessage ?? "Erreur de chargement")
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color.pokemonBackground)
        .navigationTitle("Détails")
        .task {
            await viewModel.loadPokemon(id: pokemonId)
        }
    }
}

struct StatCard: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundColor(.textSecondary)
            
            Text(value)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.pokemonBackground)
        .cornerRadius(8)
    }
}
