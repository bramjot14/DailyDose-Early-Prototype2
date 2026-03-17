import Foundation

final class AppStore: ObservableObject {
    @Published var medications: [Medication] {
        didSet { save() }
    }

    @Published var history: [DoseLog] {
        didSet { save() }
    }

    private let medicationsKey = "DailyDose.medications"
    private let historyKey = "DailyDose.history"

    init() {
        let decoder = JSONDecoder()

        if let medicationData = UserDefaults.standard.data(forKey: medicationsKey),
           let savedMedications = try? decoder.decode([Medication].self, from: medicationData) {
            self.medications = savedMedications
        } else {
            self.medications = [
                Medication(name: "Vitamin D", dosage: "1000 IU", time: Date().addingTimeInterval(60 * 60)),
                Medication(name: "Omega 3", dosage: "1 capsule", time: Date().addingTimeInterval(-20 * 60))
            ]
        }

        if let historyData = UserDefaults.standard.data(forKey: historyKey),
           let savedHistory = try? decoder.decode([DoseLog].self, from: historyData) {
            self.history = savedHistory
        } else {
            self.history = []
        }
    }

    func addMedication(name: String, dosage: String, time: Date, startDate: Date?, endDate: Date?) {
        let med = Medication(name: name, dosage: dosage, time: time, startDate: startDate, endDate: endDate)
        medications.append(med)
    }

    func markTaken(_ med: Medication) {
        history.insert(DoseLog(medicationName: med.name, dosage: med.dosage, takenAt: Date(), status: .taken), at: 0)

        if let idx = medications.firstIndex(where: { $0.id == med.id }) {
            medications[idx].lastTakenAt = Date()
        }
    }

    private func save() {
        let encoder = JSONEncoder()

        if let medicationData = try? encoder.encode(medications) {
            UserDefaults.standard.set(medicationData, forKey: medicationsKey)
        }

        if let historyData = try? encoder.encode(history) {
            UserDefaults.standard.set(historyData, forKey: historyKey)
        }
    }
}
