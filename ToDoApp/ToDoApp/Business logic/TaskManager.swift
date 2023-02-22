//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import Foundation

/// Класс реализующий Менеджер задач, соответствует протоколу ITaskManager
///
/// Содержит методы:
///
/// func allTasks() -> [Task] - получить все задачи
///
/// func allCompletedTasks() -> [Task] - получить завершенные задачи
///
/// func allNotCompletedTasks() -> [Task] - получить не завершенные задачи
///
/// func addTask(_ task: Task) - добавить задачу
///
/// func deleteTask(_ task: Task) - удалить задачу
final class TaskManager {
	private var tasks: [Task]
	
	init(with tasks: [Task]) {
		self.tasks = tasks
	}
	/// Получить все задачи
	/// - Returns: массив задач
	func allTasks() -> [Task] {
		tasks
	}
	/// Получить все завершенные задачи
	/// - Returns: массив завершенных задач
	func allCompletedTasks() -> [Task] {
		tasks.filter { task in task.completed }
	}
	/// Получить все не завершенные задачи
	/// - Returns: массив не завершенных задач
	func allNotCompletedTasks() -> [Task] {
		tasks.filter { task in !task.completed }
	}
	/// Добавить задачу
	/// - Parameter task: задача
	func addTask(_ task: Task) {
		tasks.append(task)
	}
	/// Удалить задачу
	/// - Parameter task: задача
	func deleteTask(_ task: Task) {
		tasks.removeAll { currentTask in currentTask === task }
	}
}
