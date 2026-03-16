import SwiftUI

struct DoseRowView: View {
    let med: Medication
    let onTaken: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "pills")
                .font(.title3)
                .frame(width: 34)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(med.name)
                        .font(.headline)
                    Spacer()
                    StatusBadge(status: status)
                }

                Text("\(timeString(med.time)) • \(med.dosage)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if status != .taken {
                Button("Taken") { onTaken() }
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical, 6)
    }

    enum MedStatus { case dueNow, overdue, upcoming, taken }

    private var status: MedStatus {
        if takenToday { return .taken }

        let now = Date()
        let diff = med.time.timeIntervalSince(now)
        if abs(diff) <= 15 * 60 { return .dueNow }
        if diff < -15 * 60 { return .overdue }
        return .upcoming
    }

    private var takenToday: Bool {
        guard let last = med.lastTakenAt else { return false }
        return Calendar.current.isDateInToday(last)
    }

    private func timeString(_ d: Date) -> String {
        let f = DateFormatter()
        f.timeStyle = .short
        return f.string(from: d)
    }
}

private struct StatusBadge: View {
    let status: DoseRowView.MedStatus

    var body: some View {
        Text(label)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(background)
            .foregroundStyle(foreground)
            .clipShape(Capsule())
    }

    private var label: String {
        switch status {
        case .dueNow: return "Due Now"
        case .overdue: return "Overdue"
        case .upcoming: return "Upcoming"
        case .taken: return "Taken"
        }
    }

    private var background: Color {
        switch status {
        case .dueNow: return Color.orange.opacity(0.18)
        case .overdue: return Color.red.opacity(0.18)
        case .upcoming: return Color.blue.opacity(0.16)
        case .taken: return Color.green.opacity(0.18)
        }
    }

    private var foreground: Color {
        switch status {
        case .dueNow: return .orange
        case .overdue: return .red
        case .upcoming: return .blue
        case .taken: return .green
        }
    }
}
