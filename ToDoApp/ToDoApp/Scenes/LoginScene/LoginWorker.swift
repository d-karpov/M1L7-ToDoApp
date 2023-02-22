//
//  LoginWorker.swift
//  ToDoApp
//
//  Created by Денис Карпов on 22.02.2023.
//

import Foundation

struct LoginDTO {
	let success: Int
	let login: String
	let lastLoginDate: Date
}

protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

final class LoginWorker: ILoginWorker {
	func login(login: String, password: String) -> LoginDTO {
		if login == "Admin" && password == "pa$$32!" {
			return LoginDTO(
				success: 1,
				login: login,
				lastLoginDate: Date()
			)
		} else {
			return LoginDTO(
				success: 0,
				login: login,
				lastLoginDate: Date()
			)
		}
	}
}
