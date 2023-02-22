//
//  Repository.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import Foundation

/// Протокол описывающий интерфейс для шаблона Репозиторий
///
/// Обязывает реализовать следующие методы:
///
/// func list() -> [T] - получить массив данных
protocol IRepository {
	associatedtype T
	
	func list() -> [T]
}
/// Класс реализующий протокол IRepository для фиксированного массива данных
final class StubRepository: IRepository {
	typealias T = Task
	
	func list() -> [T] {
		let tasks = [
			ImportantTask(title: "See lesson", completed: true, priority: .low),
			RegularTask(title: "Go to shop", completed: false),
			RegularTask(title: "Create Stub for lesson", completed: true),
			ImportantTask(title: "Make Swiftbook homework", completed: false, priority: .high),
			ImportantTask(title: "Make lesson's test", completed: false, priority: .medium)
		]
		return tasks
	}
}
