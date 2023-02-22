//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import UIKit


/// 
protocol IToDoListViewController: AnyObject {
	func render(viewData: ToDoListModel.ViewData)
}

class ToDoListViewController: UITableViewController {
	
	private var viewData = ToDoListModel.ViewData(sections: [ToDoListModel.ViewData.Section]())
	var interactor: IToDoListInteractor?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Todo List"
		interactor?.viewIsReady()
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewData.sections.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.sections[section].title
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.sections[section].tasks.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let tasks = viewData.sections[indexPath.section].tasks
		let task = tasks[indexPath.row]
		var content = cell.defaultContentConfiguration()
		switch task {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let range = (task.secondaryText as NSString).range(of: task.priority)
			let priorityText = NSMutableAttributedString(string: task.secondaryText)
			priorityText.addAttributes(redText, range: range)
			content.text = task.text
			content.secondaryAttributedText = priorityText
			cell.accessoryType = task.isCompleted ? .checkmark : .none
			cell.tintColor = .red
			cell.backgroundColor = task.isOverdue ? .systemPink : .white
		case .regularTask(let task):
			content.text = task.text
			cell.accessoryType = task.isCompleted ? .checkmark : .none
			cell.tintColor = .red
		}
		cell.contentConfiguration = content
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.taskSelected(request: ToDoListModel.Request(indexPath: indexPath))
	}
}

extension ToDoListViewController: IToDoListViewController {
	
	func render(viewData: ToDoListModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
