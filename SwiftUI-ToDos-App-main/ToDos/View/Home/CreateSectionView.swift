////NAME : UTSAV KALATHIYA-101413639

import SwiftUI
import SwiftData

struct CreateSectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name: String = ""
    @State private var iconName: String = "house"

    let availableIcons = ["house", "heart", "calendar", "flag.fill", "sun.max.fill", "graduationcap", "exclamationmark.3"]

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }

            Section(header: Text("Icon")) {
                Picker("Icon", selection: $iconName) {
                    ForEach(availableIcons, id: \.self) { icon in
                        Image(systemName: icon).tag(icon)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section {
                Button("Create List") {
                    let newList = ReminderList(name: name, iconName: iconName)
                    modelContext.insert(newList)
                    try? modelContext.save()
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .navigationTitle("Add Segment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CreateSectionView()
}
