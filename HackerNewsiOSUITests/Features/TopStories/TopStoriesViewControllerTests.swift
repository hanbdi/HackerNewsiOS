//
//  TopStoriesViewControllerTests.swift
//  HackerNewsiOSUITests
//
//  Created by Dang Duong Hung on 16/2/20.
//  Copyright © 2020 Dang Duong Hung. All rights reserved.
//

import XCTest

class TopStoriesViewControllerTests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }

    func testAppearance() {
        // Given
        app.launch()
       
        // Then
        let navBar = app.navigationBars["Top Stories"]
        XCTAssertTrue(navBar.exists)
       
        let table = app.tables["storiesTableView"]
        XCTAssertTrue(table.exists)
        
        table.cells.allElementsBoundByIndex.first?.tap()
    }
        
    func testNavigateToStoryDetails() {
        // Given
        app.launch()
        
        let table = app.tables["storiesTableView"]
        XCTAssertTrue(table.exists)
        
        let firstCell = table.cells.element(boundBy: 1)
        _ = firstCell.waitForExistence(timeout: 20)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let urlButton = app.buttons["URL"]
        _ = urlButton.waitForExistence(timeout: 20)
        XCTAssertTrue(urlButton.exists)
    }
}
