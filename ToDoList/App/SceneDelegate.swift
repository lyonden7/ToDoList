//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Денис Васильев on 15.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		
		let toDoListVC = ModuleBuilder.createToDoListModule()
		let navigationController = UINavigationController(rootViewController: toDoListVC)
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
    }
}

