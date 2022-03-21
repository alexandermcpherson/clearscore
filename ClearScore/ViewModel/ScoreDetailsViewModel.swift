//
//  ScoreDetailsViewModel.swift
//  ClearScore
//
//  Created by Alex McPherson on 20/03/2022.
//

import Foundation

final class ScoreDetailsViewModel {

    // MARK: - Properties
    private let scoreBand: Int
    private let clientRef: String
    private let status: String
    private let hasEverDefaulted: Bool
    private let percentageCreditUsed: Int

    // MARK: - Init
    init(scoreBand: Int,
         clientRef: String,
         status: String,
         hasEverDefaulted: Bool,
         percentageCreditUsed: Int) {

        self.scoreBand = scoreBand
        self.clientRef = clientRef
        self.status = status
        self.hasEverDefaulted = hasEverDefaulted
        self.percentageCreditUsed = percentageCreditUsed
    }

    func getScoreBandText() -> String {
        return  "Score band: " + String(scoreBand)
    }

    func getClientRefText() -> String {
        return "Client reference: " + clientRef
    }

    func getStatusText() -> String {
        return "Status: " + status
    }

    func getHasEverDefaultedText() -> String {
        let hasEverDefualtedText = hasEverDefaulted ? "Yes" : "No"
        return "Has Defaulted: " + hasEverDefualtedText
    }

    func getPercentaageCreditUsedText() -> String {
        return "Percentage of credit used: " + String(percentageCreditUsed) + "%"
    }
}
