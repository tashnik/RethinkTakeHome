//
//  RethinkTakeHomeUITests.swift
//  RethinkTakeHomeUITests
//
//  Created by David Potashnik on 7/14/23.
//

import XCTest

final class RethinkTakeHomeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testCountButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let countButton = app.buttons["Count"]
        XCTAssertTrue(countButton.exists)
        
        countButton.tap()
        
        let okButton = app.alerts["Rethink!"].scrollViews.otherElements.buttons["Ok"]
        XCTAssertTrue(okButton.exists)
        
        okButton.tap()
    }
    
    func testUserDropdown() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let userQuery = app.scrollViews.otherElements
        XCTAssertTrue(userQuery.element.exists)
        
        userQuery.disclosureTriangles["User"].tap()
        userQuery.scrollViews.otherElements.staticTexts["Leanne Graham"].tap()
    }
    

    func testRunThrough() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        XCTAssertTrue(elementsQuery.element.exists)
        elementsQuery.disclosureTriangles["User"].tap()
        
        let elementsQuery2 = elementsQuery.scrollViews.otherElements
        XCTAssertTrue(elementsQuery2.element.exists)
        elementsQuery2.staticTexts.allElementsBoundByIndex.first?.tap()
        
        // Comments section will not expand if a post has not been selected
        elementsQuery.disclosureTriangles["Comments"].tap()
        
        let okButton = app.alerts["Rethink!"].scrollViews.otherElements.buttons["Ok"]
        XCTAssertTrue(okButton.exists)
        
        okButton.tap()
        
        elementsQuery.disclosureTriangles["Posts"].tap()
        
        elementsQuery2.staticTexts.allElementsBoundByIndex.first?.tap()
        
        elementsQuery.disclosureTriangles["Comments"].tap()
        
        elementsQuery.disclosureTriangles.allElementsBoundByIndex.last?.tap()
        elementsQuery.disclosureTriangles.allElementsBoundByIndex.last?.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
