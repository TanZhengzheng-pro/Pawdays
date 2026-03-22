import SwiftUI

struct QuickStatsSection: View {
    let stats: PetStats

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Highlights")
                .font(.headline)

            VStack(spacing: 12) {
                statRow(title: "Consistency", value: stats.streakText)
                statRow(title: "Most logged", value: stats.favoriteActivity)
                statRow(title: "Latest note", value: stats.latestNote)
            }
        }
    }

    private func statRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.subheadline.weight(.semibold))
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(14)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
