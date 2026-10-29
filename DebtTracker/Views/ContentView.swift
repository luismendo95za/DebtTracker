import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: DebtStore
    @State private var showingAdd = false
    @State private var selectedDebt: Debt?

    var body: some View {
        NavigationStack {
            Group {
                if store.debts.isEmpty {
                    ContentUnavailableView(
                        "Sin deudas",
                        systemImage: "creditcard",
                        description: Text("Pulsa + para añadir tu primera deuda.")
                    )
                } else {
                    List {
                        ForEach(store.debts) { debt in
                            DebtRowView(debt: debt)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .onTapGesture { selectedDebt = debt }
                        }
                        .onDelete(perform: store.delete)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Mis deudas")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddDebtView()
            }
            .sheet(item: $selectedDebt) { debt in
                AmortizeView(debt: debt)
            }
        }
    }
}

#Preview {
    let store = DebtStore()
    store.debts = [
        Debt(title: "Préstamo coche", total: 12000, paid: 4500),
        Debt(title: "Tarjeta", total: 800, paid: 800)
    ]
    return ContentView().environmentObject(store)
}
