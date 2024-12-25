//
//  StorageManager.swift
//  TodoListApp
//
//  Created by Alexander Shevtsov on 23.12.2024.
//

import CoreData

final class StorageManager {
    // синглтон с приватным init
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    // если свойство в StorageManager оно не ленивое!
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoListApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    // эта + инит чтобы сократить просто до viewContext
    private let viewContext: NSManagedObjectContext
    // иниц после свойств
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    // добавление объекта в базу
    func create(_ taskName: String, completion: (TodoTask) -> Void) { // добавление в массив
        let task = TodoTask(context: viewContext) // создаем задачу
        task.title = taskName // присваиваем title имя
        completion(task) // передаем в комплишн
        saveContext() // сохранение в базе
    }
    // обработка возврата данных в массив TodoTask через помплишн
    func fetchData(completion: (Result<[TodoTask], Error>) -> Void) {
        let fetchRequest = TodoTask.fetchRequest() // загрузка данных из базы
        
        do { // обращаемся к контексту, выполняем запрос, получается массив
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks)) // возвращаем массив
        } catch let error { // обработка ошибки
            completion(.failure(error))
        }
    }
        // задача которую меняем | новый параметр для неё
    func update(_ task: TodoTask, newName: String) {
        task.title = newName // обращаемся к task, свойство title = новое имя
        saveContext()
    }
    
    func delete(_ task: TodoTask) { // обращаемся к контексту, выз метод del...
        viewContext.delete(task) // ... и передаем task
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() { // публичный!
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
