//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Денис Васильев on 15.02.2023.
//

import UIKit

/// Контроллер, отображающий список выполненных и невыполненных задач.
class ToDoListViewController: UITableViewController {
	
	private var sectionForTaskManager: ISectionForTaskManagerAdapter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "ToDoList"
		
		setup()
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		sectionForTaskManager.getSectionTitles().count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		sectionForTaskManager.getTasksForSection(section: section).count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = getTaskForIndex(indexPath)
		let cell = UITableViewCell()
		var contentConfiguration = cell.defaultContentConfiguration()
		
		if let task = task as? ImportantTask {
			let priorityText = "\(task.taskPriority)"
			let text = "\(priorityText) \(task.title)"
			
			let range = (text as NSString).range(of: priorityText)
			let mutableAttributedString = NSMutableAttributedString(string: text)
			mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
			
			contentConfiguration.attributedText = mutableAttributedString
			contentConfiguration.secondaryText = "Deadline: " + task.deadLine.formatted()
			contentConfiguration.textProperties.color = task.deadLine < Date() ? .systemPink : .black
			cell.contentConfiguration = contentConfiguration
		} else {
			contentConfiguration.text = task.title
		}
		
		cell.tintColor = .black
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.systemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration
		cell.accessoryType = task.isCompleted ? .checkmark : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		sectionForTaskManager.getSectionTitles()[section]
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let task = getTaskForIndex(indexPath)
		task.isCompleted.toggle()
		tableView.reloadData()
	}
	
	// MARK: - Private methods
	private func setup() {
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(repository.getTask())
		
		sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}
	
	/// return Task from IndexPath
	private func getTaskForIndex(_ indexPath: IndexPath) -> Task {
		sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
	}
}
