//
//  LoginRouter.swift
//  ToDoApp
//
//  Created by Денис Карпов on 22.02.2023.
//

import UIKit

protocol IRouterLogin {
	func routeToToDoList()
}

final class LoginRouter: IRouterLogin {
	private weak var viewController: UIViewController?
	
	init(viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func routeToToDoList() {
		let destination = assemblyToDoList()
		navigateToSomewhere(source: viewController!, destination: destination)
	}
	
	private func navigateToSomewhere(source: UIViewController, destination: UIViewController) {
		source.show(destination, sender: nil)
	}
	
	private func assemblyToDoList() -> UIViewController {
		
		let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		guard let viewController = storyBoard.instantiateViewController(
			withIdentifier: "ToDoListViewController"
		) as? ToDoListViewController else {
			fatalError("No ToDoListViewController at Main storyboard")
		}
		
		let navViewController = UINavigationController(rootViewController: viewController)
		navViewController.navigationBar.prefersLargeTitles = true
		navViewController.modalPresentationStyle = .fullScreen
		
		let taskManager = TaskManager(with: StubRepository().list())
		let orderedTaskManager = OrderedTaskManager(taskManager)
		let sectionManager = SectionsForTaskMangerAdapter(orderedTaskManager)
		let presentor = ToDoListPresenter(view: viewController)
		let interactor = ToDoListInteractor(
			sectionManager: sectionManager,
			presenter: presentor
		)
		viewController.interactor = interactor
		
		return navViewController
	}
}
