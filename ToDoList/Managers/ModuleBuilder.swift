//
//  ModuleBuilder.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import UIKit

/// Протокол, описывающий сборку экранов.
protocol IModuleBuilder {
	/// Метод для сборки экрана Main.
	/// - Returns: Готовый экран MainViewController.
	static func createMainModule() -> UIViewController
}

/// Класс, реализующий протокол для сборки экранов.
final class ModuleBuilder: IModuleBuilder {
	static func createMainModule() -> UIViewController {
		let view = MainViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = MainPresenter(
			view: view,
			sectionManager: sections
		)
		
		view.presenter = presenter
		taskManager.addTasks(tasks: repository.getTasks())
		
		return view
	}
}
