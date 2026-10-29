import SwiftUI

struct DebtRowView: View {
    let debt: Debt

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(debt.title)
                    .font(.headline)
                Spacer()
                if debt.isCompleted {
                    Label("Pagada", systemImage: "checkmark.seal.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }

            ProgressView(value: debt.progress)
                .progressViewStyle(.linear)
                .tint(debt.isCompleted ? .green : .accentColor)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .padding(.vertical, 2)

            HStack {
                Text("\(debt.paid.asCurrency) de \(debt.total.asCurrency)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(debt.percentage)%")
                    .font(.subheadline.bold())
                    .monospacedDigit()
            }
        }
        .padding()
        .background(.background.secondary, in: RoundedRectangle(cornerRadius: 14))
        .contentShape(Rectangle())
        .animation(.easeInOut, value: debt.progress)
    }
}

extension Double {
    var asCurrency: String {
        formatted(.currency(code: Locale.current.currency?.identifier ?? "EUR"))
    }
}
