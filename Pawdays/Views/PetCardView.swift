import SwiftUI

struct PetCardView: View {
    let pet: Pet
    let isSelected: Bool
    let summary: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(pet.color)
                    .frame(height: 76)

                Image(systemName: pet.icon)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(.primary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(pet.name)
                    .font(.headline)
                Text(pet.type)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("\(pet.age) · \(summary)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(14)
        .frame(width: 190)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
        }
        .shadow(color: .black.opacity(isSelected ? 0.08 : 0.04), radius: 16, y: 8)
    }
}
