import Foundation

final class DebtStore: ObservableObject {
    @Published var debts: [Debt] = [] {
        didSet { save() }
    }

    private let key = "debts.v1"

    init() {
        load()
    }

    func add(title: String, total: Double) {
        debts.append(Debt(title: title, total: total))
    }

    /// Suma una cantidad amortizada a la deuda (sin pasarse del total).
    func amortize(_ debt: Debt, amount: Double) {
        guard let index = debts.firstIndex(where: { $0.id == debt.id }) else { return }
        debts[index].paid = min(debts[index].paid + amount, debts[index].total)
    }

    func delete(at offsets: IndexSet) {
        debts.remove(atOffsets: offsets)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(debts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Debt].self, from: data) else { return }
        debts = decoded
    }
}
