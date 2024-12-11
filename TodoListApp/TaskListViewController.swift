//
//  ViewController.swift
//  TodoListApp
//
//  Created by Alexander Shevtsov on 11.12.2024.
//

import UIKit

final class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }

    @objc private func addNewTask() {
        
    }
}

// MARK: - Setup UI
private extension TaskListViewController {
    func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance() // конфиг
        navBarAppearance.backgroundColor = UIColor(
        red: 21/255,
        green: 101/255,
        blue: 192/255,
        alpha: 194/255
        )
        // цвет заголовка в мал состоянии и большом
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        // применяем конфиг к small состоянию и big
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        // Add button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        // цвет кнопок в NavBar
        navigationController?.navigationBar.tintColor = .white
    }
}
