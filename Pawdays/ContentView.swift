import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PetJournalViewModel()
    @State private var selectedPetID: Pet.ID?

    private var selectedPet: Pet? {
        if let selectedPetID,
           let match = viewModel.pets.first(where: { $0.id == selectedPetID }) {
            return match
        }
        return viewModel.pets.first
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    petSelector
                    todaySummary

                    if let selectedPet {
                        CareTimelineSection(entries: viewModel.entries(for: selectedPet))
                        QuickStatsSection(stats: viewModel.stats(for: selectedPet))
                    }
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Pawdays")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            selectedPetID = selectedPet?.id
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Record every little moment with your pets")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))

            Text("A calm daily journal for meals, walks, mood, health and all the tiny details that matter.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var petSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("My Pets")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.pets) { pet in
                        PetCardView(
                            pet: pet,
                            isSelected: pet.id == selectedPet?.id,
                            summary: viewModel.summary(for: pet)
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                selectedPetID = pet.id
                            }
                        }
                    }
                }
            }
        }
    }

    private var todaySummary: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Today")
                    .font(.headline)
                Spacer()
                Text(Date.now.formatted(.dateTime.month(.abbreviated).day()))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                SummaryMetricView(title: "Entries", value: "\(viewModel.todayEntryCount)", icon: "square.text.square")
                SummaryMetricView(title: "Walks", value: "\(viewModel.todayWalkCount)", icon: "figure.walk")
                SummaryMetricView(title: "Meals", value: "\(viewModel.todayMealCount)", icon: "fork.knife")
            }
        }
    }
}

#Preview {
    ContentView()
}
