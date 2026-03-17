import SwiftUI

struct MedicationHistoryView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        NavigationStack {
            List {
                if store.history.isEmpty {
                    ContentUnavailableView("No history yet",
                                           systemImage: "clock",
                                           description: Text("Mark a dose as Taken to see it here."))
                } else {
                    ForEach(groupedKeys, id: \.self) { day in
                        Section(day) {
                            ForEach(grouped[day] ?? []) { log in
                                HistoryRowView(log: log)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }

    private var grouped: [String: [DoseLog]] {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return Dictionary(grouping: store.history) { f.string(from: $0.takenAt) }
    }

    private var groupedKeys: [String] {
        var seen = Set<String>()
        var keys: [String] = []
        let f = DateFormatter()
        f.dateStyle = .medium

        for log in store.history {
            let k = f.string(from: log.takenAt)
            if !seen.contains(k) {
                seen.insert(k)
                keys.append(k)
            }
        }
        return keys
    }
}
