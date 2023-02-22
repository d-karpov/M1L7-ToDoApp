//
//  ToDoListPresenter.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import Foundation

protocol IToDoListPresenter {
	func present(response: ToDoListModel.Response)
}

final class ToDoListPresenter: IToDoListPresenter {
	
	private weak var view: IToDoListViewController?
	
	init(view: IToDoListViewController) {
		self.view = view
	}
	
	func present(response: ToDoListModel.Response) {
		var sections = [ToDoListModel.ViewData.Section]()
		response.sections.forEach { section in
			sections.append(
				ToDoListModel.ViewData.Section(
					title: section.title,
					tasks: prepareTasks(tasks: section.tasks)
				)
			)
		}
		view?.render(viewData: ToDoListModel.ViewData(sections: sections))
	}
	
	private func prepareTasks(tasks: [Task]) -> [ToDoListModel.ViewData.Task] {
		tasks.map { task in prepareTask(task: task)}
	}
	
	private func prepareTask(task: Task) -> ToDoListModel.ViewData.Task {
		if let task = task as? ImportantTask {
			let date = "\(task.dueDate.formatted(date: .numeric, time: .omitted))"
			let result = ToDoListModel.ViewData.ImportantTask(
				text: task.title,
				priority: "\(task.priority)",
				secondaryText: "\(task.priority) To be done defore: \(date)",
				isCompleted: task.completed,
				isOverdue: task.dueDate < Date.now)
			return .importantTask(result)
		} else {
			return .regularTask(ToDoListModel.ViewData.RegularTask(
				text: task.title,
				isCompleted: task.completed)
			)
		}
	}
}

// MARK: - ImportantTask Priority CustomStringConvertible extension
extension ImportantTask.Priority: CustomStringConvertible {
	var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
