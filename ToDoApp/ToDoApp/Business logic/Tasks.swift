//
//  Tasks.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import Foundation

/// Класс описывающий задачу
class Task {
	/// Краткое описание задачи
	let title: String
	/// Статус завершения
	var completed: Bool
	
	init(title: String, completed: Bool) {
		self.title = title
		self.completed = completed
	}
}

/// Класс описывающий обычную задачу, унаследован от Task
final class RegularTask: Task { }

/// Класс описывающий важную задачу, унаследован от Task
final class ImportantTask: Task {
	/// Перечисление содержащее возможные приоритеты задач
	enum Priority: Int {
		case high = 1, medium, low
	}
	/// Приоритет задачи
	var priority: Priority
	/// Срок выполнения
	var dueDate: Date {
		getDueDate()
	}
	init(title: String, completed: Bool, priority: Priority) {
		self.priority = priority
		super.init(title: title, completed: completed)
	}
	private func getDueDate() -> Date {
		Calendar.current.date(byAdding: .day,value: priority.rawValue,to: Date.now)!
	}
}
