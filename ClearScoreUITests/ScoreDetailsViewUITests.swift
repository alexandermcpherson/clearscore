//
//  ScoreDetailsViewUITests.swift
//  ClearScoreUITests
//
//  Created by Alex McPherson on 21/03/2022.
//

import XCTest

class ScoreDetailsViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        sleep(1)
    }

    func testDetailsLabelsExist() {
        let app = XCUIApplication()
        app.launch()
        app.buttons.element.tap()
        XCTAssertTrue(app.staticTexts["scoreBandLabel"].exists)
        XCTAssertTrue(app.staticTexts["clientRefLabel"].exists)
        XCTAssertTrue(app.staticTexts["statusLabel"].exists)
        XCTAssertTrue(app.staticTexts["hasNeverDefaultedLabel"].exists)
        XCTAssertTrue(app.staticTexts["percentageCreditUsedLabel"].exists)
    }

    func testDetailsLabelsShowsCorrectInfo() {
        let app = XCUIApplication()
        app.launch()
        app.buttons.element.tap()
        XCTAssertEqual(app.staticTexts["scoreBandLabel"].label, "Score band: 4")
        XCTAssertEqual(app.staticTexts["clientRefLabel"].label, "Client reference: CS-SED-655426-708782")
        XCTAssertEqual(app.staticTexts["statusLabel"].label, "Status: MATCH")
        XCTAssertEqual(app.staticTexts["hasNeverDefaultedLabel"].label, "Has Defaulted: No")
        XCTAssertEqual(app.staticTexts["percentageCreditUsedLabel"].label, "Percentage of credit used: 44%")
    }
}
