//
//  MainModel.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import Foundation

enum MainModel {
	/// Cтруктура, описывающая подготовленные поля для отображения данных на экране.
	struct ViewData {
		/// Cтруктура, описывающая подготовленные поля для отображения данных обычной задачи на экране.
		struct RegularTask {
			/// Название задачи
			let name: String
			/// Статус выполнения задачи.
			let isDone: Bool
		}
		
		/// Cтруктура, описывающая подготовленные поля для отображения данных важной задачи на экране.
		struct ImportantTask {
			/// Название задачи.
			let name: String
			/// Статус выполнения задачи.
			let isDone: Bool
			/// Просрочена ли задача.
			let isOverDue: Bool
			/// Дедлайн задачи.
			let deadLine: String
			/// Приоритет задачи.
			let priority: String
		}
		
		/// Перечисление Task для исключения опционалов и гарантированной передачи только валидных данных, подготовленных Presenter для отображения.
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		/// Cтруктура, описывающая подготовленные поля для отображения данных секции на экране.
		struct Section {
			/// Название секции.
			let title: String
			/// Массив задач.
			let tasks: [Task]
		}
		
		let tasksBySection: [Section]
	}
}
