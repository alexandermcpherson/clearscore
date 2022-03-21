//
//  ScoreDetailsViewModelTests.swift
//  ClearScoreTests
//
//  Created by Alex McPherson on 21/03/2022.
//

import XCTest

@testable import ClearScore

class ScoreDetailsViewModelTests: XCTestCase {

    var scoreViewModel: ScoreViewModel!
    var scoreDetailsViewModel: ScoreDetailsViewModel!

    override func setUp() {

        scoreViewModel = ScoreViewModel()

        guard let scoreBand = scoreViewModel.creditReportInfo.value?.scoreBand,
              let clientRef = scoreViewModel.creditReportInfo.value?.clientRef,
              let status = scoreViewModel.creditReportInfo.value?.status,
              let hasEverDefaulted = scoreViewModel.creditReportInfo.value?.hasEverDefaulted,
              let percentageCreditUsed = scoreViewModel.creditReportInfo.value?.percentageCreditUsed  else { return }

        scoreDetailsViewModel = ScoreDetailsViewModel(scoreBand: scoreBand,
                                                      clientRef: clientRef,
                                                      status: status,
                                                      hasEverDefaulted: hasEverDefaulted,
                                                      percentageCreditUsed: percentageCreditUsed)

    }

    override func tearDownWithError() throws {
        scoreViewModel = nil
        scoreDetailsViewModel = nil
    }

    func testScoreBandTextIsEqualToScoreBand() {
        guard let scoreBandText = scoreDetailsViewModel?.getScoreBandText() else { return }
        XCTAssertEqual(scoreBandText, "Score band: 4")
    }

    func testClientRefTextIsEqualToClientReference() {
        guard let clientRefText = scoreDetailsViewModel?.getClientRefText() else { return }
        XCTAssertEqual(clientRefText, "Client reference: CS-SED-655426-708782")
    }

    func testStatusTextIsEqualToStatus() {
        guard let status = scoreDetailsViewModel?.getStatusText() else { return }
        XCTAssertEqual(status, "Status: MATCH")
    }

    func testHasEverDefaultedTextIsEqualToHasEverDefaulted() {
        guard let hasEverDefaulted = scoreDetailsViewModel?.getHasEverDefaultedText() else { return }
        XCTAssertEqual(hasEverDefaulted, "Has Defaulted: No")
    }

    func testPercentageCreditUsedTextIsEqualToPercentageCreditUsed() {
        guard let percentageCreditUsed = scoreDetailsViewModel?.getPercentaageCreditUsedText() else { return }
        XCTAssertEqual(percentageCreditUsed, "Percentage of credit used: 44%")
    }
}
