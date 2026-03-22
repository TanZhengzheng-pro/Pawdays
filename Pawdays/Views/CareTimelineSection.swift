import SwiftUI

struct CareTimelineSection: View {
    let entries: [CareEntry]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Records")
                .font(.headline)

            ForEach(entries) { entry in
                HStack(alignment: .top, spacing: 14) {
                    Image(systemName: entry.category.icon)
                        .font(.title3)
                        .frame(width: 42, height: 42)
                        .background(Color.accentColor.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(entry.title)
                                .font(.subheadline.weight(.semibold))
                            Spacer()
                            Text(entry.time.formatted(date: .omitted, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Text(entry.note)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(entry.category.rawValue)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.tint)
                    }
                }
                .padding(14)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}
