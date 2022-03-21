//
//  ScoreDetailsViewController.swift
//  ClearScore
//
//  Created by Alex McPherson on 20/03/2022.
//

import UIKit

class ScoreDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var scoreBandLabel: UILabel!
    @IBOutlet private weak var clientRefLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var hasEverDefaultedLabel: UILabel!
    @IBOutlet private weak var percentageCreditUsedLabel: UILabel!

    // MARK: - Properties
    var scoreDetailsViewModel: ScoreDetailsViewModel?

    // MARK: - Constants
    private enum Constants {
        static let title = "Credit details"
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        setupLabels()
    }

    // MARK: - Methods
    private func setupLabels() {
        scoreBandLabel.text = scoreDetailsViewModel?.getScoreBandText()
        clientRefLabel.text = scoreDetailsViewModel?.getClientRefText()
        statusLabel.text = scoreDetailsViewModel?.getStatusText()
        hasEverDefaultedLabel.text = scoreDetailsViewModel?.getHasEverDefaultedText()
        percentageCreditUsedLabel.text = scoreDetailsViewModel?.getPercentaageCreditUsedText()
    }

}
