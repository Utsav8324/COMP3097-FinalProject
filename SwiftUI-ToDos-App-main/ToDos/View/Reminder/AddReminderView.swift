//NAME : KARAN PARMAR-101427974

import SwiftUI
import SwiftData

struct AddReminderView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var reminderList: ReminderList

    @State private var name: String = ""
    @State private var dueDate: Date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reminder")) {
                    TextField("Enter reminder title", text: $name)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }

                Section {
                    Button("Create Reminder") {
                        let newReminder = Reminder(name: name, createdAt: .now, dueDate: dueDate)
                        reminderList.reminder.append(newReminder)
                        modelContext.insert(newReminder)
                        try? modelContext.save()
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("Add Reminder")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Group {
        if let container = try? ModelContainer(for: ReminderList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)) {
            let exampleList = ReminderList(name: "Today", iconName: "calendar")
            AddReminderView(reminderList: exampleList)
                .modelContainer(container)
        } else {
            Text("Preview failed")
        }
    }
}
