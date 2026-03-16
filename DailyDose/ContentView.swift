import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayScheduleView()
                .tabItem { Label("Today", systemImage: "calendar") }

            AddMedicationView()
                .tabItem { Label("Add", systemImage: "plus.circle.fill") }

            MedicationHistoryView()
                .tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
        }
    }
}
