import Foundation

struct CareEntry: Identifiable, Hashable {
    enum Category: String, CaseIterable, Hashable {
        case meal = "Meal"
        case walk = "Walk"
        case mood = "Mood"
        case health = "Health"
        case grooming = "Grooming"

        var icon: String {
            switch self {
            case .meal: return "fork.knife"
            case .walk: return "figure.walk"
            case .mood: return "heart.text.square"
            case .health: return "cross.case"
            case .grooming: return "sparkles"
            }
        }
    }

    let id = UUID()
    let petName: String
    let category: Category
    let title: String
    let note: String
    let time: Date
}
