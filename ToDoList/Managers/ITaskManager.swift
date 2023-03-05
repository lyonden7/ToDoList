//
//  ITaskManager.swift
//  ToDoList
//
//  Created by Денис Васильев on 19.02.2023.
//

/// Протокол для TaskManager.
protocol ITaskManager {
	/// Метод, возвращающий все задачи.
	/// - Returns: Список задач.
	func getAllTasks() -> [Task]
	
	/// Метод, возвращающий выполненные задачи.
	/// - Returns: Список задач.
	func getCompletedTasks() -> [Task]
	
	/// Метод, возвращающий невыполненные задачи.
	/// - Returns: Список задач.
	func getUncompletedTasks() -> [Task]
	
	/// Метод для добавления списка задач в список.
	/// - Parameter tasks: Список задач.
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager { }

extension ImportantTask.TaskPriority: CustomStringConvertible {
	var description: String {
		switch self {
		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high:
			return "!!!"
		}
	}
}


