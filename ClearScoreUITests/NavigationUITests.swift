//
//  NavigationUITests.swift
//  ClearScoreUITests
//
//  Created by Alex McPherson on 01/03/2022.
//

import XCTest

class NavigationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        sleep(1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationFromDashboardToDetailsAndBackToDashboard() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["showDetailsButton"].tap()
        app.navigationBars["Credit details"].buttons["Dashboard"].tap()
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
