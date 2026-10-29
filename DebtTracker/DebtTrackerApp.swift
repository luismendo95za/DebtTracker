import SwiftUI

@main
struct DebtTrackerApp: App {
    @StateObject private var store = DebtStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
