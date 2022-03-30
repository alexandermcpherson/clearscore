//
//  ScoreViewModel.swift
//  ClearScore
//
//  Created by Alex McPherson on 08/03/2022.
//

import Foundation

final class ScoreViewModel {

    // MARK: - Constants
    private enum Constants { // Why do I use enum and not a struct? I cannot accidently instantiate this an error will be thrown
        static let endpoint = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    }

    // MARK: - Properties
    private let networkService = NetworkService(endpoint: Constants.endpoint)

    // MARK: - Observables
    @Published var error: String?
    @Published var creditReportInfo: CreditReportInfo?

    // MARK: - Init
    init() {
        if NetworkMonitor.shared.isReachable {
            getCreditScore()
        } else {
            error = NetworkError.NotConnectedToNetwork.rawValue
        }
    }

    // MARK: - Methods
    private func getCreditScore() {
        networkService.getData(object: CreditReport.self) { [weak self] success, object, error in
            if success && error == nil {
                guard let object = object else { return }
                self?.creditReportInfo = object.creditReportInfo
            } else {
                if let error = error as? HTTPStatusCode {
                    self?.error = error.description
                } else if let error = error as? NetworkError {
                    self?.error = error.rawValue
                } else {
                    self?.error = error?.localizedDescription
                }
            }
        }
    }

    func getScoreNumber() -> Int? {
        return creditReportInfo?.score
    }

    func getScoreText() -> String? {
        guard let scoreText = creditReportInfo?.score else { return nil }
        return String(scoreText)
    }

    func getMaxScoreValueNumber() -> Int? {
        return creditReportInfo?.maxScoreValue
    }

    func getMaxScoreValueText() -> String? {
        guard let maxScoreValueText = creditReportInfo?.maxScoreValue else { return nil }
        return "out of " + String(maxScoreValueText)
    }
}
