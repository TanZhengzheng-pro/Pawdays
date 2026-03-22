import Foundation
import SwiftUI

struct PetStats {
    let streakText: String
    let favoriteActivity: String
    let latestNote: String
}

final class PetJournalViewModel: ObservableObject {
    @Published var pets: [Pet] = [
        Pet(name: "Mochi", type: "British Shorthair", age: "2 years", color: Color.orange.opacity(0.18), icon: "cat.fill"),
        Pet(name: "Bobo", type: "Toy Poodle", age: "5 years", color: Color.blue.opacity(0.18), icon: "dog.fill"),
        Pet(name: "Yuzu", type: "Rabbit", age: "1 year", color: Color.green.opacity(0.18), icon: "hare.fill")
    ]

    @Published var entries: [CareEntry] = {
        let calendar = Calendar.current
        let now = Date()
        return [
            CareEntry(petName: "Mochi", category: .meal, title: "Breakfast finished", note: "Ate 85g salmon recipe with good appetite.", time: calendar.date(byAdding: .hour, value: -2, to: now) ?? now),
            CareEntry(petName: "Mochi", category: .mood, title: "Very playful morning", note: "Chased feather toy for 12 minutes.", time: calendar.date(byAdding: .hour, value: -1, to: now) ?? now),
            CareEntry(petName: "Bobo", category: .walk, title: "Neighborhood walk", note: "25-minute easy walk before lunch.", time: calendar.date(byAdding: .hour, value: -3, to: now) ?? now),
            CareEntry(petName: "Bobo", category: .grooming, title: "Brushed coat", note: "No tangles, skin looked healthy.", time: calendar.date(byAdding: .day, value: -1, to: now) ?? now),
            CareEntry(petName: "Yuzu", category: .health, title: "Weight check", note: "Stable at 1.8kg, appetite normal.", time: calendar.date(byAdding: .day, value: -1, to: now) ?? now),
            CareEntry(petName: "Yuzu", category: .meal, title: "Fresh hay refill", note: "Finished most of the previous bowl.", time: calendar.date(byAdding: .minute, value: -90, to: now) ?? now)
        ]
    }()

    private let calendar = Calendar.current

    func entries(for pet: Pet) -> [CareEntry] {
        entries
            .filter { $0.petName == pet.name }
            .sorted { $0.time > $1.time }
    }

    func summary(for pet: Pet) -> String {
        let count = entries(for: pet).count
        return "\(count) records"
    }

    func stats(for pet: Pet) -> PetStats {
        let petEntries = entries(for: pet)
        let favorite = Dictionary(grouping: petEntries, by: \.category)
            .max(by: { $0.value.count < $1.value.count })?.key.rawValue ?? "Meal"

        return PetStats(
            streakText: "9 day streak",
            favoriteActivity: favorite,
            latestNote: petEntries.first?.note ?? "No notes yet"
        )
    }

    var todayEntryCount: Int {
        entries.filter { calendar.isDateInToday($0.time) }.count
    }

    var todayWalkCount: Int {
        entries.filter { calendar.isDateInToday($0.time) && $0.category == .walk }.count
    }

    var todayMealCount: Int {
        entries.filter { calendar.isDateInToday($0.time) && $0.category == .meal }.count
    }
}
