//
//  ScoreViewModelTests.swift
//  ClearScoreTests
//
//  Created by Alex McPherson on 16/03/2022.
//

import XCTest

@testable import ClearScore

class ScoreViewModelTests: XCTestCase {

    var scoreViewModel: ScoreViewModel!

    override func setUp() {
        scoreViewModel = ScoreViewModel()
    }

    override func tearDownWithError() throws {
        scoreViewModel = nil
    }

    func testScoreViewModelIsNotNilWhenConnectedToNetwork() {
        XCTAssertNotNil(scoreViewModel)
    }

    func testScoreTextValueNotNilWhenConnectedToNetworkAndCreditDataRequested() {
        XCTAssertNotNil(scoreViewModel.getScoreText)
    }

    func testScoreRepresentedAsTextIsEqualTo514() {
        guard let scoreText = scoreViewModel.getScoreText() else { return }
        XCTAssertEqual(scoreText, "514")
    }

    func testScoreIntValueNotNilWhenConnectedToNetworkAndCreditDataRequested() {
        XCTAssertNotNil(scoreViewModel.getScoreNumber)
    }

    func testScoreRepresentedAsIntIsEqualTo514() {
        guard let scoreNumber = scoreViewModel.getScoreNumber() else { return }
        XCTAssertEqual(scoreNumber, 514)
    }

    func testMaxScoreTextValueNotNilWhenConnectedToNetworkAndCreditDataRequested() {
        XCTAssertNotNil(scoreViewModel.getMaxScoreValueText)
    }

    func testMaxScoreRepresentedAsTextIsEqualToOutOf700() {
        guard let maxScoreText = scoreViewModel.getMaxScoreValueText() else { return }
        XCTAssertEqual(maxScoreText, "out of 700")
    }

    func testMaxScoreIntValueNotNilWhenConnectedToNetworkAndCreditDataRequested() {
        XCTAssertNotNil(scoreViewModel.getMaxScoreValueNumber)
    }

    func testMaxScoreRepresentedAsIntIsEqualTo700() {
        guard let maxScoreNumber = scoreViewModel.getMaxScoreValueNumber() else { return }
        XCTAssertEqual(maxScoreNumber, 700)
    }

    func testErrorStringValueIsNilWhenConnectedToNetwork() {
        XCTAssertNil(scoreViewModel?.error)
    }

}
