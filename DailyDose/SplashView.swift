import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var store: AppStore
    @State private var goNext = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 14) {
                Image(systemName: "pills.fill")
                    .font(.system(size: 64))
                Text("DailyDose")
                    .font(.system(size: 34, weight: .bold))
                Text("Medication Reminder")
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                goNext = true
            }
        }
        .fullScreenCover(isPresented: $goNext) {
            ContentView()
                .environmentObject(store)
        }
    }
}
