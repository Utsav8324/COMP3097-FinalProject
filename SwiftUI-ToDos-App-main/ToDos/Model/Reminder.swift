//
//  Reminder.swift
//  ToDos
//NAME : KARAN PARMAR-101427974

import Foundation
import SwiftData

@Model
final class Reminder {
    var name: String
    var isCompleted: Bool
    var createdAt: Date
    var dueDate: Date?

    init(name: String, isCompleted: Bool = false, createdAt: Date = .now, dueDate: Date? = nil) {
        self.name = name
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.dueDate = dueDate
    }
}
