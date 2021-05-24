//
//  WeeklyViewUITests.swift
//  Trending Tv ShowsUITests
//
//  Created by Alex Paul on 5/24/21.
//

import XCTest

class WeeklyViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
    }

  
    // Check for Featured button
    func test_featured_button_Displays() {
        app.launch()
        XCTAssertTrue(app.buttons["Featured"].exists)
    }
    
    //Tap Featured button
    func test_featured_button_tap() {
        app.launch()
        app.buttons["Featured"].tap()
        XCTAssertTrue(app.staticTexts["This Week"].exists)
    }
    
    // Check for Search bar
    func test_search_bar_exists()
    {
        app.launch()
        XCTAssertTrue(app.searchFields["Seach Tv Shows"].exists)
    }
    
    // Search TV Shows
    func test_fiter_tv_shows()
    {
        app.launch()
        let count = app.collectionViews.cells.count
        let searchField = app.searchFields.element(boundBy: 0)
        searchField.tap()
        searchField.typeText("something")
        let newCount = app.collectionViews.cells.count
        XCTAssertTrue(newCount !=  count, "Tv Shows not filtered")
    }
    
    // Check for TV Shows
    func test_tv_shows_exists()
    {
        app.launch()
        XCTAssertTrue(app.collectionViews.cells.count > 0, "No Tv Shows")
    }
    
    // TV Show Details
    func test_tv_show_press()
    {
        app.launch()
        let cell = app.collectionViews.cells.element(boundBy: 0)
        cell.tap()
        XCTAssertTrue(app.staticTexts["TV Show Details"].exists)
    }
   

}
