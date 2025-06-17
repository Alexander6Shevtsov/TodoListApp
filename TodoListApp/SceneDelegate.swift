//
//  SceneDelegate.swift
//  TodoListApp
//
//  Created by Alexander Shevtsov on 11.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // вместо _ -> windowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) //иниц окно и передаем в параметр 
        window?.makeKeyAndVisible() // видимость окна вкл
        // стартовый экран с NavC
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
    }
        // уход в фоновый режим
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
