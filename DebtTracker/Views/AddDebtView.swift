import SwiftUI

struct AddDebtView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: DebtStore

    @State private var title = ""
    @State private var total: Double?

    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty && (total ?? 0) > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Deuda") {
                    TextField("Título (ej. Préstamo coche)", text: $title)
                    TextField("Total a pagar", value: $total, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Nueva deuda")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Añadir") {
                        store.add(title: title.trimmingCharacters(in: .whitespaces),
                                  total: total ?? 0)
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
}
