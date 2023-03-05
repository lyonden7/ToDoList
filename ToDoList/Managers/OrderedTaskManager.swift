//
//  OrderedTaskManager.swift
//  ToDoList
//
//  Created by Денис Васильев on 19.02.2023.
//

import Foundation

/// Предоставляет список задач, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	// MARK: - Public methods
	public func getAllTasks() -> [Task] {
		sorted(tasks: taskManager.getAllTasks())
	}
	
	public func getCompletedTasks() -> [Task] {
		sorted(tasks: taskManager.getCompletedTasks())
	}
	
	public func getUncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.getUncompletedTasks())
	}
	
	public func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}
	
	// MARK: - Private methods
	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
			
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
			
			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}
			
			return false
		}
	}
}
