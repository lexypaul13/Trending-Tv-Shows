//
//  Trending_Tv_ShowsUITests.swift
//  Trending Tv ShowsUITests
//
//  Created by Alex Paul on 5/24/21.
//

import XCTest

class Trending_Tv_ShowsUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    func test_featured_button_Displays() {
        app.launch()
        XCTAssertTrue(app.buttons["Featured"].exists)
    }
    
    func test_featured_button_tap() {
        app.launch()
        app.buttons["Featured"].tap()
        XCTAssertTrue(app.staticTexts["This week"].exists)
    }
    

}
