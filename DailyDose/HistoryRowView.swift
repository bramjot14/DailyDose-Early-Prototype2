import SwiftUI

struct HistoryRowView: View {
    let log: DoseLog

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: log.status == .taken ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title3)
                .foregroundStyle(log.status == .taken ? .green : .red)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.medicationName)
                    .font(.headline)
                Text("\(timeString(log.takenAt)) • \(log.dosage) • \(log.status.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }

    private func timeString(_ d: Date) -> String {
        let f = DateFormatter()
        f.timeStyle = .short
        return f.string(from: d)
    }
}
