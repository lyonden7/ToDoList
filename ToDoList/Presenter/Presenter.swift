//
//  Presenter.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import Foundation
import UIKit

/// Протокол, описывающий View.
protocol IView: AnyObject {
	/// Метод, обеспечивающий передачу данных из ViewData для отображения данных на экране.
	/// - Parameter viewData: Экземпляр ViewData (структура, описывающая подготовленные поля для отображения данных на экране).
	func render(viewData: ViewData)
}

/// Протокол, описывающий Presenter.
protocol IPresenter: AnyObject {
	init(
		view: IView,
		taskManager: ITaskManager,
		repository: ITaskRepository,
		sectionForTaskManager: ISectionForTaskManagerAdapter
	)
	
	/// Метод для получения списка задач из репозитория.
	func getTasks()
	
	/// Метод, возвращающий заголовок экрана.
	/// - Returns: Заголовок.
	func setTitle() -> String
	
	/// Метод, возвращающий количество секций для таблицы.
	/// - Returns: Количество секций для таблицы.
	func setNumberOfSections() -> Int
	
	/// Метод, возвращающий количество строк для выбранной секции таблицы.
	/// - Parameter section: Номер секции таблицы.
	/// - Returns: Количество строк выбранной секции.
	func setNumberOfRowsInSection(section: Int) -> Int
	
	/// Метод, конфигурирующий ячейку по выбранному индексу.
	/// - Parameter indexPath: Индекс ячейки.
	func configureCell(at indexPath: IndexPath)
	
	/// Метод, возвращающий заголовок для секции таблицы.
	/// - Parameter section: Номер секции.
	/// - Returns: Заголовок секции.
	func setTitleForHeaderInSection(section: Int) -> String
	
	/// Метод, меняющий статус выполнения задачи по индексу ячейки.
	/// - Parameter indexPath: Индекс ячейки.
	func changeTaskStatus(at indexPath: IndexPath)
}

final class Presenter: IPresenter {
	private weak var view: IView?
	private let taskManager: ITaskManager
	private let repository: ITaskRepository
	private let sectionForTaskManager: ISectionForTaskManagerAdapter
	
	required init(
		view: IView,
		taskManager: ITaskManager,
		repository: ITaskRepository,
		sectionForTaskManager: ISectionForTaskManagerAdapter
	) {
		self.view = view
		self.taskManager = taskManager
		self.repository = repository
		self.sectionForTaskManager = sectionForTaskManager
		getTasks()
	}
	
	public func getTasks() {
		taskManager.addTasks(repository.getTasks())
	}
	
	public func setTitle() -> String {
		"ToDoList"
	}
	
	public func setNumberOfSections() -> Int {
		sectionForTaskManager.getSectionTitles().count
	}
	
	public func setNumberOfRowsInSection(section: Int) -> Int {
		sectionForTaskManager.getTasksForSection(section: section).count
	}
	
	public func configureCell(at indexPath: IndexPath) {
		let task = sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
		
		if let task = task as? ImportantTask {
			let priorityText = "\(task.taskPriority)"
			let text = "\(priorityText) \(task.title)"

			let range = (text as NSString).range(of: priorityText)
			let mutableAttributedString = NSMutableAttributedString(string: text)
			mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
			
			view?.render(viewData:
							ViewData(
								text: mutableAttributedString,
								secondaryText: "Deadline: " + task.deadLine.formatted(),
								isDeadlineExpired: task.deadLine < Date(),
								isCompleted: task.isCompleted
							)
			)
		} else {
			view?.render(viewData:
							ViewData(
								text: NSMutableAttributedString(string: task.title),
								secondaryText: nil,
								isDeadlineExpired: false,
								isCompleted: task.isCompleted
							)
			)
		}
	}
	
	public func setTitleForHeaderInSection(section: Int) -> String {
		sectionForTaskManager.getSectionTitles()[section].uppercased()
	}
	
	public func changeTaskStatus(at indexPath: IndexPath) {
		let task = sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
		task.isCompleted.toggle()
	}
}
