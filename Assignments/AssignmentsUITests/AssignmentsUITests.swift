//
//  AssignmentsUITests.swift
//  AssignmentsUITests
//
//  Created by Al-Amin on 2023/02/14.
//

import XCTest

final class AssignmentsUITests: XCTestCase {
    
    var app: XCUIApplication!
    var searchField: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        searchField = app.searchFields.firstMatch
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_SearchField_is_enabled() {
        let navigationBar = app.navigationBars["Github Repositories"]
        
        let searchField = navigationBar.searchFields["Search Repository"]
        XCTAssert(searchField.isEnabled)
    }
    
    func test_SearchField_exists() {
        XCTAssertTrue(searchField.exists, "Search field not found")
    }
    
    func test_SearchField_NotEmpty() {
        searchField.tap()
        searchField.typeText("Swift")
        
        XCTAssertNotNil(searchField.title)
    }
    
}
