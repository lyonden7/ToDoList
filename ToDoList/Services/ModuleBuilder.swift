//
//  ModuleBuilder.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import UIKit

/// Протокол, описывающий сборку экранов.
protocol IModuleBuilder {
	/// Метод для сборки экрана ToDoList.
	/// - Returns: Готовый экран ToDoListViewController.
	static func createToDoListModule() -> UIViewController
}

/// Класс, реализующий протокол для сборки экранов.
final class ModuleBuilder: IModuleBuilder {
	static func createToDoListModule() -> UIViewController {
		let view = ToDoListViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository = TaskRepositoryStub()
		let sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = Presenter(
			view: view,
			taskManager: taskManager,
			repository: repository,
			sectionForTaskManager: sectionForTaskManager
		)
		
		view.presenter = presenter
		
		return view
	}
}
