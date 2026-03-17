import SwiftUI

struct AddMedicationView: View {
    @EnvironmentObject private var store: AppStore

    @State private var name = ""
    @State private var dosage = ""
    @State private var time = Date()

    @State private var useStartEnd = false
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()

    @State private var showSavedAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Medication Info") {
                    TextField("Medication name", text: $name)
                    TextField("Dosage (e.g., 500 mg)", text: $dosage)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                }

                Section("Optional Schedule") {
                    Toggle("Use start & end date", isOn: $useStartEnd)
                    if useStartEnd {
                        DatePicker("Start date", selection: $startDate, displayedComponents: .date)
                        DatePicker("End date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    }
                }

                Section {
                    Button {
                        save()
                    } label: {
                        Text("Save Medication")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(saveDisabled)
                }
            }
            .navigationTitle("Add Medication")
            .alert("Saved", isPresented: $showSavedAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Medication saved and available in Today Schedule.")
            }
        }
    }

    private var saveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        dosage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func save() {
        let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedDosage = dosage.trimmingCharacters(in: .whitespacesAndNewlines)

        store.addMedication(
            name: cleanedName,
            dosage: cleanedDosage,
            time: time,
            startDate: useStartEnd ? startDate : nil,
            endDate: useStartEnd ? endDate : nil
        )

        name = ""
        dosage = ""
        time = Date()
        useStartEnd = false
        startDate = Date()
        endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        showSavedAlert = true
    }
}
