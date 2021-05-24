//
//  FavouriteViewUITests.swift
//  Trending Tv ShowsUITests
//
//  Created by Alex Paul on 5/24/21.
//

import XCTest

class FavouriteViewUITests: XCTestCase {

  
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
    }

  
    // Check for Favourite button
    func test_favourite_button_Displays() {
        app.launch()
        XCTAssertTrue(app.buttons["Most Recent"].exists)
    }
    
    // Press on favourite button
    func test_favourite_button_tap() {
        app.buttons["Most Recent"].tap()
        XCTAssertTrue(app.staticTexts["Saved Tv Shows"].exists)
    }
    
    // Check for favourite shows
    func test_favourite_shows_exists()
    {
        print(app.debugDescription)
        XCTAssertTrue(app.tables.cells.count > 0, "No Tv Shows")
    }
    
    // Press on favourite Shows
    func test_favourite_show_press()
    {
        let cell = app.tables.cells.element(boundBy: 0)
        cell.tap()
        XCTAssertTrue(app.staticTexts["TV Show Details"].exists)
    }


}
