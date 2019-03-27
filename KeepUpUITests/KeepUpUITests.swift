//
//  KeepUpUITests.swift
//  KeepUpUITests
//
//  Created by Prateek Kambadkone on 2019/03/15.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

import XCTest

class KeepUpUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
            //Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state
            //- such as interface orientation
            //- required for your tests before they run.
            //The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchingForArtistAndPressingOnShowInfoButtonToViewInfoAndReturn() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.textFields["Search Artist"].tap()
        app.textFields["Search Artist"].typeText("Linkin Park")
        app.buttons["search"].tap()
        let infoButton = app.buttons["info"]
        infoButton.tap()
        let expect = XCTestExpectation(description: "Linkin Park")
        _ = XCTWaiter.wait(for: [expect], timeout: 15)
        XCTAssert(app.staticTexts["Linkin Park"].exists)
        app.buttons["Close"].tap()
    }

    func testSearchingForEmptyTextandPressingSearchToShowAlertDialogAndNoSearchResult() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.buttons["search"].tap()
        app.alerts["Empty Search"].buttons["Ok"].tap()
        XCTAssert(!app.buttons["info"].exists)
    }

    func testIfViewAllEditButtonShowsAllFavouriteArtists() {
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.tables.cells.allElementsBoundByIndex[1].tap()
    }
}
