//
//  desafioUITests.swift
//  desafioUITests
//
//  Created by Arthur Hardmann on 13/07/23.
//

import XCTest

final class HomeViewControllerUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        print(app.debugDescription)
    }
    
    func testTableViewUI() throws {
        app.launch()
        let tableView = app.tables.matching(identifier: "tableViewIdentifier")
        
        XCTAssertNotNil(tableView)
        XCTAssert(app.staticTexts["Marvel Comics"].exists)
        
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(tableView.cells.count > 0)
        }
    }
}
