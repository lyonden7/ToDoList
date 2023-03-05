//
//  SectionForTaskManagerAdapter.swift
//  ToDoList
//
//  Created by Денис Васильев on 19.02.2023.
//

import Foundation

/// Протокол адаптера для TaskManager, в котором есть возможность представлять данные посекционно.
protocol ISectionForTaskManagerAdapter {
	/// Метод, возвращающий секции.
	/// - Returns: Секции.
	func getSections() -> [Section]
	
	/// Метод, возвращающий по номеру секции необходимый список задач.
	/// - Parameter section: Секция..
	/// - Returns: Список задач.
	func getTasksForSection(section: Section) -> [Task]
	
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)?
	
	func getSectionIndex(section: Section) -> Int
	
	func getSection(forIndex index: Int) -> Section
}

enum Section: CaseIterable {
	case completed
	case uncompleted
	
	var title: String {
		switch self {
		case .completed:
			return "Completed tasks"
		case .uncompleted:
			return "Uncompleted tasks"
		}
	}
}

/// Адаптер для TaskManager.
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {

	private let sections: [Section] = [.uncompleted, .completed]
	
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func getSections() -> [Section] {
		sections
	}
	
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.getCompletedTasks()
		case .uncompleted:
			return taskManager.getUncompletedTasks()
		}
	}
	
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex { task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		
		return nil
	}
	
	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}
	
	func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)
		return sections[i]
	}
}
