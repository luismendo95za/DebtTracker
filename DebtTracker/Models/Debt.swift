import Foundation

struct Debt: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var total: Double
    var paid: Double = 0

    var remaining: Double { max(total - paid, 0) }

    /// Valor entre 0 y 1
    var progress: Double {
        guard total > 0 else { return 0 }
        return min(paid / total, 1)
    }

    var percentage: Int { Int((progress * 100).rounded()) }
    var isCompleted: Bool { paid >= total }
}
