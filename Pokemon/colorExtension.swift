import SwiftUI

extension Color {
    static let pokemonBackground = Color(red: 0.97, green: 0.97, blue: 0.98)
    static let cardBackground = Color.white
    static let textPrimary = Color(red: 0.1, green: 0.1, blue: 0.1)
    static let textSecondary = Color(red: 0.6, green: 0.6, blue: 0.6)
    
    static func typeColor(_ typeName: String) -> Color {
        switch typeName.lowercased() {
        case "normal": return Color(red: 0.68, green: 0.68, blue: 0.68)
        case "fire": return Color(red: 0.96, green: 0.49, blue: 0.31)
        case "water": return Color(red: 0.33, green: 0.71, blue: 0.98)
        case "grass": return Color(red: 0.49, green: 0.90, blue: 0.49)
        case "electric": return Color(red: 1.0, green: 0.84, blue: 0.21)
        case "ice": return Color(red: 0.51, green: 0.87, blue: 0.92)
        case "fighting": return Color(red: 0.76, green: 0.31, blue: 0.31)
        case "poison": return Color(red: 0.79, green: 0.34, blue: 0.79)
        case "ground": return Color(red: 0.92, green: 0.81, blue: 0.55)
        case "flying": return Color(red: 0.67, green: 0.67, blue: 0.98)
        case "psychic": return Color(red: 0.96, green: 0.51, blue: 0.81)
        case "bug": return Color(red: 0.67, green: 0.84, blue: 0.27)
        case "rock": return Color(red: 0.72, green: 0.64, blue: 0.55)
        case "ghost": return Color(red: 0.59, green: 0.51, blue: 0.70)
        case "dragon": return Color(red: 0.44, green: 0.27, blue: 0.98)
        case "dark": return Color(red: 0.44, green: 0.39, blue: 0.35)
        case "steel": return Color(red: 0.71, green: 0.77, blue: 0.87)
        case "fairy": return Color(red: 0.96, green: 0.69, blue: 0.92)
        default: return Color.gray
        }
    }
}
