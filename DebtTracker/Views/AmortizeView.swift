import SwiftUI

struct AmortizeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: DebtStore

    let debt: Debt
    @State private var amount: Double?

    private var isValid: Bool { (amount ?? 0) > 0 }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Pagado", value: debt.paid.asCurrency)
                    LabeledContent("Pendiente", value: debt.remaining.asCurrency)
                }

                Section("Cantidad amortizada") {
                    TextField("Importe", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }

                if let amount, amount > debt.remaining, debt.remaining > 0 {
                    Text("El importe supera lo pendiente; se registrará solo \(debt.remaining.asCurrency).")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(debt.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        store.amortize(debt, amount: amount ?? 0)
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
        }
        .presentationDetents([.medium])
    }
}
