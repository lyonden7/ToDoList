//
//  MainModel.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import Foundation

/// Cтруктура, описывающая подготовленные поля для отображения данных на экране.
enum MainModel {
	struct ViewData {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverDue: Bool
			let deadLine: String
			let priority: String
		}
		
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		let tasksBySection: [Section]
	}
}
