//
//  MainPresenter.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import Foundation

/// Протокол, описывающий MainPresenter.
protocol IMainPresenter: AnyObject {
	/// Метод,  в котором View сообщает Presenter, что она готова к работе.
	func viewIsReady()
	/// Метод,  в котором View сообщает Presenter, что пользователь выбрал задачу.
	/// - Parameter indexPath: Индекс выбранной ячейки.
	func didTaskSelected(at indexPath: IndexPath)
}

/// Класс, реализующий MainPresenter.
final class MainPresenter: IMainPresenter {
	private weak var view: IMainViewController!
	private let sectionManager: ISectionForTaskManagerAdapter!
	
	init(view: IMainViewController, sectionManager: ISectionForTaskManagerAdapter!) {
		self.view = view
		self.sectionManager = sectionManager
	}
	
	func viewIsReady() {
		view.render(viewData: mapViewData())
	}
	
	func didTaskSelected(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.isCompleted.toggle()
		view.render(viewData: mapViewData())
	}
	
	private func mapViewData() -> MainModel.ViewData {
		var sections: [MainModel.ViewData.Section] = []
		for section in sectionManager.getSections() {
			let sectionData = MainModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section))
			)
			
			sections.append(sectionData)
		}
		
		return MainModel.ViewData(tasksBySection: sections)
	}
	
	private func mapTasksData(tasks: [Task]) -> [MainModel.ViewData.Task] {
		tasks.map { mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> MainModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let result = MainModel.ViewData.ImportantTask(
				name: task.title,
				isDone: task.isCompleted,
				isOverDue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			
			return .importantTask(result)
		} else {
			return .regularTask(MainModel.ViewData.RegularTask(name: task.title, isDone: task.isCompleted))
		}
	}
}
