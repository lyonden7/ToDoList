//
//  Tasks.swift
//  ToDoList
//
//  Created by Денис Васильев on 15.02.2023.
//

import Foundation

// MARK: - Task
/// Класс, описывающий задачу.
class Task {
	/// Название задачи
	var title: String
	/// Статус выполнения задачи.
	var isCompleted = false
	
	init(title: String, isCompleted: Bool = false) {
		self.title = title
		self.isCompleted = isCompleted
	}
}

// MARK: - RegularTask
/// Класс, описывающий обычную задачу.
final class RegularTask: Task { }

// MARK: - ImportantTask
/// Класс, описывающий важную задачу.
final class ImportantTask: Task {
	/// Перечисление возможных приоритетов задачи.
	enum TaskPriority: Int {
		case low
		case medium
		case high
	}
	
	/// Приоритет задачи.
	var taskPriority: TaskPriority
	/// Дедлайн задачи.
	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: Date())!
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
		}
	}

	init(title: String, taskPriority: TaskPriority, isCompleted: Bool = false) {
		self.taskPriority = taskPriority
		super.init(title: title, isCompleted: isCompleted)
	}
}
