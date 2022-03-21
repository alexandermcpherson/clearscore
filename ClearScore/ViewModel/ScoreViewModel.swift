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
    private var score: Int?
    private var maxScoreValue: Int?

    // MARK: - Observables
    var error: ObservableObject<String?> = ObservableObject(nil)
    var creditReportInfo: ObservableObject<CreditReportInfo?> = ObservableObject(nil)

    // MARK: - Init
    init() {
        if NetworkMonitor.shared.isReachable {
            getCreditScore()
        } else {
            error.value = NetworkError.NotConnectedToNetwork.rawValue
        }
    }

    // MARK: - Methods
    private func getCreditScore() {
        networkService.getData(object: CreditReport.self) { [weak self] success, object, error in
            if success && error == nil {
                guard let object = object else { return }
                self?.creditReportInfo.value = object.creditReportInfo
                self?.score = self?.creditReportInfo.value?.score
                self?.maxScoreValue = self?.creditReportInfo.value?.maxScoreValue
            } else {
                if let error = error as? HTTPStatusCode {
                    self?.error.value = error.description
                } else if let error = error as? NetworkError {
                    self?.error.value = error.rawValue
                } else {
                    self?.error.value = error?.localizedDescription
                }
            }
        }
    }

    func getScoreNumber() -> Int? {
        return score
    }

    func getScoreText() -> String? {
       guard let scoreText = score else { return nil }
       return String(scoreText)
    }

    func getMaxScoreValueNumber() -> Int? {
        return maxScoreValue
    }

    func getMaxScoreValueText() -> String? {
        guard let maxScoreValueText = maxScoreValue else { return nil }
        return "out of " + String(maxScoreValueText)
    }
}
