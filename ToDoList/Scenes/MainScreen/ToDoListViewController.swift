//
//  MainViewController.swift
//  ToDoList
//
//  Created by Денис Васильев on 15.02.2023.
//

import UIKit

/// Контроллер, отображающий список выполненных и невыполненных задач.
final class MainViewController: UIViewController {
	
	@IBOutlet var tableView: UITableView!
	
	private var sectionForTaskManager: ISectionForTaskManagerAdapter!
	private var viewData: ViewData!
	
	var presenter: IPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		title = presenter.setTitle()
	}
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		presenter.setNumberOfSections()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.setNumberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		presenter.configureCell(at: indexPath)
		
		var contentConfiguration = cell.defaultContentConfiguration()
		
		contentConfiguration.attributedText = viewData.text
		contentConfiguration.secondaryText = viewData.secondaryText
		contentConfiguration.textProperties.font = UIFont.systemFont(ofSize: 19)
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.color = viewData.isDeadlineExpired ? .systemPink : .black
		
		cell.tintColor = .black
		cell.accessoryType = viewData.isCompleted ? .checkmark : .none
		
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		presenter.setTitleForHeaderInSection(section: section)
	}
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.changeTaskStatus(at: indexPath)
		tableView.reloadData()
	}
}

// MARK: - IView
extension MainViewController: IView {
	func render(viewData: ViewData) {
		self.viewData = viewData
	}
}
