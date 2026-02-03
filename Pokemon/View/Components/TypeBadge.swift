import SwiftUI

struct TypeBadge: View {
    let type: String
    
    var body: some View {
        Text(type.capitalized)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.typeColor(type))
            .cornerRadius(8)
    }
}
