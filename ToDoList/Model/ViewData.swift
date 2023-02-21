//
//  ViewData.swift
//  ToDoList
//
//  Created by Денис Васильев on 20.02.2023.
//

import Foundation

/// Cтруктура, описывающая подготовленные поля для отображения данных на экране.
struct ViewData {
	let text: NSMutableAttributedString
	let secondaryText: String?
	let isDeadlineExpired: Bool
	var isCompleted: Bool
}
