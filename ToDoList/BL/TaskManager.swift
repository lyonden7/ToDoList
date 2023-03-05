//
//  TaskManager.swift
//  ToDoList
//
//  Created by Денис Васильев on 15.02.2023.
//

/// Предоставляет список задач.
final class TaskManager {
	// MARK: - Private properties
	private var taskList: [Task] = []
	
	// MARK: - Public methods
	/// Метод, возвращающий все задачи.
	/// - Returns: Список задач.
	public func getAllTasks() -> [Task] {
		taskList
	}
	
	/// Метод, возвращающий выполненные задачи.
	/// - Returns: Список задач.
	public func getCompletedTasks() -> [Task] {
		taskList.filter { $0.isCompleted }
	}
	
	/// Метод, возвращающий невыполненные задачи.
	/// - Returns: Список задач.
	public func getUncompletedTasks() -> [Task] {
		taskList.filter { !$0.isCompleted }
	}
	
	/// Метод для добавления задачи в список.
	/// - Parameter task: Задача.
	public func addTask(_ task: Task) {
		taskList.append(task)
	}
	
	/// Метод для добавления списка задач в список.
	/// - Parameter tasks: Список задач.
	public func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	
	/// Метод для удаления задачи из списка.
	/// - Parameter task: Задача.
	public func removeTask(_ task: Task) {
		taskList.removeAll { $0 === task }
	}
}
