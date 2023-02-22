//
//  ToDoListModels.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import Foundation

enum ToDoListModel {
	struct Request {
		let indexPath: IndexPath
	}
	
	struct Response {
		var sections: [Section]
		
		struct Section {
			let title: String
			var tasks: [Task]
		}
	}
	
	struct ViewData {
		let sections: [Section]
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		enum Task {
			case importantTask(ImportantTask)
			case regularTask(RegularTask)
		}
		
		struct ImportantTask {
			let text: String
			let priority: String
			let secondaryText: String
			let isCompleted: Bool
			let isOverdue: Bool
		}
		
		struct RegularTask {
			let text: String
			let isCompleted: Bool
		}
	}
}
