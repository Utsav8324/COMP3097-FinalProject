//
//  ReminderListView.swift
//  ToDos
//

import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var reminderList: ReminderList

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(reminderList.name)
                    Spacer()
                    Text("\(reminderList.reminder.filter { !$0.isCompleted }.count)")
                }
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(.primary)
                .padding(.horizontal)
                .bold()

                List {
                    ForEach(reminderList.reminder) { reminder in
                        ReminderRowView(reminder: reminder)
                            .foregroundColor(rowColor(for: reminder))
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.inset)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    NavigationLink(destination: AddReminderView(reminderList: reminderList)) {
                        HStack(spacing: 7) {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                    }
                    Spacer()
                }
            }
        }
    }

    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let reminderToDelete = reminderList.reminder[index]
            reminderList.reminder.remove(at: index)
            modelContext.delete(reminderToDelete)
        }
        try? modelContext.save()
    }

    func rowColor(for reminder: Reminder) -> Color {
        let now = Date()
        let calendar = Calendar.current
        if let dueDate = reminder.dueDate {
            if dueDate < now {
                return .red // Past due
            } else if let soon = calendar.date(byAdding: .hour, value: 48, to: now), dueDate < soon {
                return .orange // Due soon
            }
        }
        return .primary // Normal
    }
}

#Preview {
    Group {
        if let container = try? ModelContainer(for: ReminderList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)) {
            let example = ReminderList(
                name: "Scheduled",
                iconName: "calendar",
                reminder: [Reminder(name: "Lunch with Janet", dueDate: .now.addingTimeInterval(-3600))]
            )
            ReminderListView(reminderList: example)
                .modelContainer(container)
        } else {
            Text("Failed to load preview")
        }
    }
}
