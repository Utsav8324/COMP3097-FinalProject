//
//  ReminderList.swift
//  ToDos
//NAME : UTSAV KALATHIYA-101413639

import Foundation
import SwiftData

@Model
final class ReminderList: Hashable {
    static func == (lhs: ReminderList, rhs: ReminderList) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    @Attribute(.unique) var id = UUID()
    var name: String
    var iconName: String
    @Relationship(deleteRule: .cascade) var reminder = [Reminder]()

    init(name: String = "", iconName: String = "list.bullet", reminder: [Reminder] = [Reminder]()) {
        self.name = name
        self.iconName = iconName
        self.reminder = reminder
    }
}
