import SwiftUI

struct Pet: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let type: String
    let age: String
    let color: Color
    let icon: String
}
