import SwiftUI

struct TodayScheduleView: View {
    @EnvironmentObject private var store: AppStore

    private var activeMedications: [Medication] {
        store.medications
            .filter { $0.isActiveToday }
            .sorted { $0.time < $1.time }
    }

    var body: some View {
        NavigationStack {
            List {
                if activeMedications.isEmpty {
                    ContentUnavailableView("No medications for today",
                                           systemImage: "calendar.badge.exclamationmark",
                                           description: Text("Add a medication to build your first schedule."))
                } else {
                    Section {
                        ForEach(activeMedications) { med in
                            DoseRowView(med: med) {
                                store.markTaken(med)
                            }
                        }
                    } header: {
                        Text("Today’s Schedule")
                    }
                }
            }
            .navigationTitle(todayTitle)
        }
    }

    private var todayTitle: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: Date())
    }
}
