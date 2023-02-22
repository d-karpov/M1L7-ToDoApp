//
//  ToDoListInteractor.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import Foundation

protocol IToDoListInteractor {
	func viewIsReady()
	func taskSelected(request: ToDoListModel.Request)
}

final class ToDoListInteractor: IToDoListInteractor {
	private var sectionManager: ISectionsForTaskManagerAdapter
	private var presenter: IToDoListPresenter?
	
	init(sectionManager: ISectionsForTaskManagerAdapter, presenter: IToDoListPresenter) {
		self.sectionManager = sectionManager
		self.presenter = presenter
	}
	
	func taskSelected(request: ToDoListModel.Request) {
		changeStatusOfTask(request.indexPath)
		viewIsReady()
	}
	
	func viewIsReady() {
		let sections = getSections()
		presenter?.present(response: ToDoListModel.Response(sections: sections))
	}
	
	private func getSections() -> [ToDoListModel.Response.Section] {
		var sections = [ToDoListModel.Response.Section]()
		for (sectionIndex, sectionTitle) in sectionManager.getTitlesOfSections().enumerated() {
			sections.append(ToDoListModel.Response.Section(
				title: sectionTitle,
				tasks: sectionManager.getSectionTasks(at: sectionIndex))
			)
		}
		return sections
	}
	
	private func changeStatusOfTask(_ indexPath: IndexPath) {
		var section = sectionManager.getSectionTasks(at: indexPath.section)
		section[indexPath.row].completed.toggle()
	}
	
}
