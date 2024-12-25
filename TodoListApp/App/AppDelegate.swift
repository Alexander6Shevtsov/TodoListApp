//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by Alexander Shevtsov on 11.12.2024.
//

import UIKit


@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var storageManager = StorageManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
        return true
    }
    // выгрузка приложения из памяти
    func applicationWillTerminate(_ application: UIApplication) {
        storageManager.saveContext() // сохраняем данные до выгрузки
    }

}

