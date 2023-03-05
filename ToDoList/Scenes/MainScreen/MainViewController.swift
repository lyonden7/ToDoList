//
//  MainViewController.swift
//  ToDoList
//
//  Created by Денис Васильев on 15.02.2023.
//

import UIKit

/// Протокол, описывающий View.
protocol IMainViewController: AnyObject {
	/// Метод, обеспечивающий передачу данных из ViewData для отображения данных на экране.
	/// - Parameter viewData: Экземпляр ViewData (структура, описывающая подготовленные поля для отображения данных на экране).
	func render(viewData: MainModel.ViewData)
}

/// Контроллер, отображающий список выполненных и невыполненных задач.
final class MainViewController: UIViewController {
	
	@IBOutlet var tableView: UITableView!
	
	var presenter: IMainPresenter?
	
	private var viewData: MainModel.ViewData = MainModel.ViewData(tasksBySection: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "ToDoList"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		presenter?.viewIsReady()
	}
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySection.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySection[section].title.uppercased()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewData.tasksBySection[section]
		return section.tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		let tasks = viewData.tasksBySection[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		var contentConfiguration = cell.defaultContentConfiguration()
		
		switch taskData {
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText)
			taskText.append(NSAttributedString(string: task.name))
			
			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverDue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		}
		
		cell.tintColor = .systemBlue
		contentConfiguration.textProperties.font = UIFont.systemFont(ofSize: 19)
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didTaskSelected(at: indexPath)
	}
}

// MARK: - IView
extension MainViewController: IMainViewController {
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
