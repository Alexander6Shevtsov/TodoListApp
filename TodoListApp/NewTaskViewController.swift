//
//  NewTaskViewController.swift
//  TodoListApp
//
//  Created by Alexander Shevtsov on 11.12.2024.
//

import UIKit

// протокол для определения интерфейса для создания кнопок
/// Protocol that defines an interface for creating buttons.
protocol ButtonFactory {
    /// Creates a button.
    ///
    /// - Returns: A 'UIButton' instance.
    func createButton() -> UIButton
}

/// Custom implementation of the 'ButtonFactory' protocol.
final class FilledButtonFactory: ButtonFactory { // закрашенные
    /// The title of the button.
    let title: String // заголовок
    
    /// The background color of the button.
    let color: UIColor // цвет
    
    // The action to be performed when the button is tapped.
    let action: UIAction // действие
    
    /// Initialises a new custom button factory with the provided title, color, and action.
    ///
    /// - Parameters:
    ///   - title: The title of the button.
    ///   - color: The background color of the button.
    ///   - action: The action to be performed when the button is tapped.
    init(title: String, color: UIColor, action: UIAction) { // инициализатор
        self.title = title
        self.color = color
        self.action = action
    }
    
    /// Creates a button with the predefined title, color, and action.
    ///
    /// - Returns: A `UIButton` instance with the predefined attributes.
    func createButton() -> UIButton {
        // Create an attribute container and set the font | контейнер с атрибутами
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        // создание кнопки
        // Create a filled button configuration and set the background color and title
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = color
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
        
        // Create the button using the configuration
        let button = UIButton(configuration: buttonConfiguration, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

// View add new task
final class NewTaskViewController: UIViewController {
    // элементы интерфейса | lazy инициал происходит по запросу
    private lazy var taskTextField: UITextField = {
        let textField = UITextField() // обяз инициалтзтруем ...
        textField.placeholder = "New Task" // серый текст
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false // удаление констрейнтов по умолчанию | обязательно!
        return textField // ... и возвращаем
    }() // () присваение объекта
    
    private lazy var saveButton: UIButton = {
        let filledButtonFactory = FilledButtonFactory(
            title: "Save Task",
            color: UIColor.milkBlue,
            action: UIAction { [unowned self] _ in
                save()
            }
        )
        return filledButtonFactory.createButton()
    
        //        // Set attributes for button title
        //        var attributes = AttributeContainer() // иниц контейнер
        //        attributes.font = UIFont.boldSystemFont(ofSize: 18) // задаем атрибуты
        //
        //        // Create button
        //        var buttonConfig = UIButton.Configuration.filled() // синяя кнопка
        //        buttonConfig.baseBackgroundColor = UIColor.milkBlue // цвет кнопки
        //        buttonConfig.attributedTitle = AttributedString("Save Task", attributes: attributes) // название кнопки | передаем иниц контейнера
        //
        //        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction { [unowned self] _ in
        //        save()
        //        })
        //        button.translatesAutoresizingMaskIntoConstraints = false
        //        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let filledButtonFactory = FilledButtonFactory(
            title: "Cancel",
            color: UIColor.milkRed,
            action: UIAction { [unowned self] _ in
                dismiss(animated: true)
            }
        )
        return filledButtonFactory.createButton()
        
//        // Set attributes for button title
//        var attributes = AttributeContainer() // иниц контейнер
//        attributes.font = UIFont.boldSystemFont(ofSize: 18) // задаем атрибуты
//        
//        // Create button
//        var buttonConfig = UIButton.Configuration.filled() // синяя кнопка
//        buttonConfig.baseBackgroundColor = UIColor.milkRed // цвет кнопки
//        buttonConfig.attributedTitle = AttributedString("Cancel", attributes: attributes) // название кнопки | передаем иниц контейнера
//        
//        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction { [unowned self] _ in
//            dismiss(animated: true)
//        })
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
    }()
    
    weak var delegate: NewTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(taskTextField, saveButton, cancelButton)
        setConstraints() // установ консрт после размещения объектов
    }
    
    // ... можем передать любое кол элементов
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    // метод установки констреинтов
    private func setConstraints() {
        NSLayoutConstraint.activate([ // констр от верха TF до верха View
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
                                    ])
        
        NSLayoutConstraint.activate([ // констр от верха TF до верха View
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
                                    ])
        
        NSLayoutConstraint.activate([ // констр от верха TF до верха View
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
                                    ])
    }
    
    private func save() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let task = TodoTask(context: appDelegate.persistentContainer.viewContext)
        task.title = taskTextField.text
        appDelegate.saveContext()
        delegate?.reloadData()
        dismiss(animated: true)
    }
}

#Preview {
    NewTaskViewController()
}
