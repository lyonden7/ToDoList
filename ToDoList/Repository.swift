//
//  Repository.swift
//  ToDoList
//
//  Created by Денис Васильев on 19.02.2023.
//

import Foundation

/// Протокол репозитория.
protocol ITaskRepository {
	/// Метод, возвращающий список задач из репозитория.
	/// - Returns: Список задач.
	func getTask() -> [Task]
}

/// Класс, реализующий протокол репозитория.
final class TaskRepositoryStub: ITaskRepository {
	func getTask() -> [Task] {
		[
			ImportantTask(title: "Important task 1", taskPriority: .high),
			ImportantTask(title: "Important task 2", taskPriority: .medium),
			ImportantTask(title: "Important task 3", taskPriority: .low),
			RegularTask(title: "Regular task 1"),
			RegularTask(title: "Regular task 2", isCompleted: true)
		]
	}
}
