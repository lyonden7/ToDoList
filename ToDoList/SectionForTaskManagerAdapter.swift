//
//  SectionForTaskManagerAdapter.swift
//  ToDoList
//
//  Created by Денис Васильев on 19.02.2023.
//

import Foundation

/// Протокол адаптера для TaskManager.
protocol ISectionForTaskManagerAdapter {
	/// Метод, возвращающий заголовки для секций.
	/// - Returns: Заголовки для секций.
	func getSectionTitles() -> [String]
	
	/// Метод, возвращающий по номеру секции необходимый список задач.
	/// - Parameter sectionIndex: Номер секции.
	/// - Returns: Список задач.
	func getTasksForSection(section sectionIndex: Int) -> [Task]
}

/// Адаптер для TaskManager.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSectionTitles() -> [String] {
		["Uncompleted tasks", "Completed tasks"]
	}
	
	func getTasksForSection(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 1:
			return taskManager.getCompletedTasks()
		default:
			return taskManager.getUncompletedTasks()
		}
	}
}
