//
//  LoginViewController.swift
//  ToDoApp
//
//  Created by Денис Карпов on 22.02.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {
	var interactor: ILoginInteractor?
	var router: IRouterLogin?
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPass: UITextField!
	@IBAction func buttonLogin(_ sender: Any) {
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension LoginViewController: ILoginViewController {
	func render(viewModel: LoginModels.ViewModel) {
		
		let alert: UIAlertController
		
		alert = UIAlertController(
			title: viewModel.success ? "Success" : "Error",
			message: viewModel.success ? viewModel.userName : "",
			preferredStyle: UIAlertController.Style.alert
		)
		
		let action = UIAlertAction(title: "Ok", style: .default) { _ in
			if viewModel.success {
				self.router?.routeToToDoList()
			}
		}
		alert.addAction(action)
		present(alert, animated: true)
	}
}
