//
//  CreditReportModel.swift
//  ClearScore
//
//  Created by Alex McPherson on 08/03/2022.
//

import Foundation

// MARK: - CreditScore
struct CreditReport: Codable {
    let accountIDVStatus: String
    let creditReportInfo: CreditReportInfo
    let dashboardStatus, personaType: String
    let coachingSummary: CoachingSummary
    let augmentedCreditScore: JSONNull?
}

// MARK: - CoachingSummary
struct CoachingSummary: Codable {
    let activeTodo: Bool
    let activeChat: Bool
    let numberOfTodoItems: Int
    let numberOfCompletedTodoItems: Int
    let selected: Bool
}

// MARK: - CreditReportInfo
struct CreditReportInfo: Codable {
    let score: Int
    let scoreBand: Int
    let clientRef: String
    let status: String
    let maxScoreValue: Int
    let minScoreValue: Int
    let monthsSinceLastDefaulted: Int
    let hasEverDefaulted: Bool
    let monthsSinceLastDelinquent: Int
    let hasEverBeenDelinquent: Bool
    let percentageCreditUsed: Int
    let percentageCreditUsedDirectionFlag: Int
    let changedScore: Int
    let currentShortTermDebt: Int
    let currentShortTermNonPromotionalDebt: Int
    let currentShortTermCreditLimit: Int
    let currentShortTermCreditUtilisation: Int
    let changeInShortTermDebt: Int
    let currentLongTermDebt: Int
    let currentLongTermNonPromotionalDebt: Int
    let currentLongTermCreditLimit: JSONNull?
    let currentLongTermCreditUtilisation: JSONNull?
    let changeInLongTermDebt: Int
    let numPositiveScoreFactors: Int
    let numNegativeScoreFactors: Int
    let equifaxScoreBand: Int
    let equifaxScoreBandDescription: String
    let daysUntilNextReport: Int
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }

    func hash(into hasher: inout Hasher) {}
}

