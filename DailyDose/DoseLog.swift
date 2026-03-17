import Foundation

struct DoseLog: Identifiable, Codable {
    enum Status: String, Codable {
        case taken = "Taken"
        case missed = "Missed"
    }

    let id: UUID
    var medicationName: String
    var dosage: String
    var takenAt: Date
    var status: Status

    init(id: UUID = UUID(), medicationName: String, dosage: String, takenAt: Date, status: Status) {
        self.id = id
        self.medicationName = medicationName
        self.dosage = dosage
        self.takenAt = takenAt
        self.status = status
    }
}
