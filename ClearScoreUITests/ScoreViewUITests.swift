//
//  ScoreViewUITests.swift
//  ClearScoreUITests
//
//  Created by Alex McPherson on 21/03/2022.
//

import XCTest

class ScoreViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        sleep(1)
    }

    func testLabelsExist() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["yourCreditScoreIsLabel"].exists)
        XCTAssertTrue(app.staticTexts["scoreLabel"].exists)
        XCTAssertTrue(app.staticTexts["maxScoreLabel"].exists)
    }

    func testLabelsShowsCorrectInfo() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertEqual(app.staticTexts["yourCreditScoreIsLabel"].label, "Your credit score is")
        XCTAssertEqual(app.staticTexts["scoreLabel"].label, "514")
        XCTAssertEqual(app.staticTexts["maxScoreLabel"].label, "out of 700")
    }
}
