//
//  ViewController.swift
//  TodoListApp
//
//  Created by Alexander Shevtsov on 11.12.2024.
//

import UIKit

protocol NewTaskViewControllerDelegate: AnyObject {
    func reloadData()
}

final class TaskListViewController: UITableViewController {
    
    private var taskList: [TodoTask] = []
    private let cellID = "task"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white
        setupNavigationBar()
        fetchData()
    }
    // переход на View для добавления new task
    @objc private func addNewTask() {
        let newTaskVC = NewTaskViewController() // создаем экземпляр
        newTaskVC.delegate = self
        present(newTaskVC, animated: true) // открываем VC
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) // обьект ячейки
        let task = taskList[indexPath.row] // извлекаем объект из массива по индексу текущей строки
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
    
    private func fetchData() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        
        let fetchRequest = TodoTask.fetchRequest() // создаем запос к базе
        
        do { // наполняем массив
            taskList = try  appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - NewTaskViewControllerDelegate
extension TaskListViewController: NewTaskViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}

// MARK: - Setup UI
private extension TaskListViewController {
    func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance() // конфиг
        navBarAppearance.backgroundColor = UIColor.milkBlue
        
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



#Preview {
    TaskListViewController()
}
