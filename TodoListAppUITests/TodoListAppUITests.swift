//
//  TodoListAppUITests.swift
//  TodoListAppUITests
//
//  Created by Alexander Shevtsov on 09.05.2025.
//

import XCTest

final class TodoListAppUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown()  {
        super.tearDown()
    }
    
    // добавляет редактирует удаляет и проверяет что удалилось
    func testExample() {
        let app = XCUIApplication() // иниц самого приложения
        app.launch() // запуск симулятора
        
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".navigationBars.buttons[\"Add\"]",".buttons.firstMatch",".buttons[\"Add\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.cells.textFields["Task"].firstMatch.typeText("Foo")
        app/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.cells.firstMatch.tap()
        app.cells.textFields["Task"].firstMatch.typeText(" v2")
        app/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.cells/*@START_MENU_TOKEN@*/.firstMatch/*[[".containing(.staticText, identifier: \"таска2\").firstMatch",".containing(.other, identifier: nil).firstMatch",".firstMatch"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        app.buttons["Delete"].tap()
        
        XCTAssertEqual(app.cells.count, 0)
    }
    
    // добавляет редактирует и проверяет сохраненный текст
    func testExample2() {
        let app = XCUIApplication() // иниц самого приложения
        app.launch() // запуск симулятора
        
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".navigationBars.buttons[\"Add\"]",".buttons.firstMatch",".buttons[\"Add\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.cells.textFields["Task"].firstMatch.typeText("Foo")
        app/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.cells.firstMatch.tap()
        app.cells.textFields["Task"].firstMatch.typeText(" v2")
        app/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.cells.staticTexts["Foo v2"].exists)
    }
}
