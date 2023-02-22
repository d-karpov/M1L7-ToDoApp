//
//  SceneDelegate.swift
//  ToDoApp
//
//  Created by Денис Карпов on 21.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.rootViewController = assemblyLogin()
		window.makeKeyAndVisible()
		self.window = window
	}
	
	private func assemblyLogin() -> UIViewController {
		let storyboard = UIStoryboard(name: "LoginScreen", bundle: Bundle.main)
		
		guard let viewController = storyboard.instantiateViewController(
			withIdentifier: "LoginViewController"
		) as? LoginViewController else {
			fatalError("No LoginViewController at LoginScreen storyboard")
		}
		
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: viewController)
		let router = LoginRouter(viewController: viewController)
		let interactor = LoginInteractor(worker: worker, presenter: presenter)
		
		viewController.interactor = interactor
		viewController.router = router
		
		return viewController
	}

}

