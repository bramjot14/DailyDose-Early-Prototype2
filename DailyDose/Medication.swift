import Foundation

struct Medication: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var dosage: String
    var time: Date
    var startDate: Date?
    var endDate: Date?
    var lastTakenAt: Date?

    init(id: UUID = UUID(),
         name: String,
         dosage: String,
         time: Date,
         startDate: Date? = nil,
         endDate: Date? = nil,
         lastTakenAt: Date? = nil) {
        self.id = id
        self.name = name
        self.dosage = dosage
        self.time = time
        self.startDate = startDate
        self.endDate = endDate
        self.lastTakenAt = lastTakenAt
    }

    var isActiveToday: Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let startDate, calendar.startOfDay(for: startDate) > today {
            return false
        }

        if let endDate, calendar.startOfDay(for: endDate) < today {
            return false
        }

        return true
    }
}
