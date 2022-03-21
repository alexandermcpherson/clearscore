//
//  ScoreViewController.swift
//  ClearScore
//
//  Created by Alex McPherson on 01/03/2022.
//

import UIKit

class ScoreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var scoreView: ScoreView!
    @IBOutlet private weak var yourCreditScoreIsLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var maxScoreValueLabel: UILabel!

    // MARK: - Constants
    private enum Constants {
        static let navTitle = "Dashboard"
        static let okAlertButtonTitle = "OK"
        static let alertErrorTitle = "Error"
        static let mainStoryboardName = "Main"
        static let scoreDetailsViewControllerName = "scoreDetailsViewController"
    }

    // MARK: - Properties
    private var scoreViewModel = ScoreViewModel()
    private var shownScoreOnce = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.navTitle
        setupBinders()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Lets not hide the UI for consecutive reloading of this view i.e coming back from the details view.
        showScoreInfo(isHidden: shownScoreOnce ? false : true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shownScoreOnce = true
        // We've now shown the score once so don't hide it.
        showScoreInfo(isHidden: shownScoreOnce ? true : false)
    }

    // MARK: - Methods
    private func showScoreInfo(isHidden: Bool) {
        scoreView.isHidden = isHidden ? true : false
        yourCreditScoreIsLabel.isHidden = isHidden ? true : false
        scoreLabel.isHidden = isHidden ? true : false
        maxScoreValueLabel.isHidden = isHidden ? true : false
    }

    private func redrawScoreView() {
        scoreView.setNeedsDisplay()
    }

    private func setupBinders() {
        scoreViewModel.creditReportInfo.bind { [weak self] info in
            if info != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.scoreLabel.text = self?.scoreViewModel.getScoreText()
                    guard let score = self?.scoreViewModel.getScoreNumber() else { return }
                    self?.scoreView.currentScore = score

                    self?.maxScoreValueLabel.text = self?.scoreViewModel.getMaxScoreValueText()
                    guard let maxScoreValue = self?.scoreViewModel.getMaxScoreValueNumber() else { return }
                    self?.scoreView.maxScoreValue = maxScoreValue

                    self?.redrawScoreView()
                    self?.showScoreInfo(isHidden: false)
                }
            }
        }
        scoreViewModel.error.bind { [weak self] error in
            if error != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.showScoreInfo(isHidden: true)
                    self?.showInfoAlertWith(Constants.alertErrorTitle, message: error)
                }
            }
        }
    }
    
    private func showInfoAlertWith(_ title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okAlertButtonTitle, style: .default) { (_) in }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Actions
    @IBAction func didTapShowDetailsButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)

        guard let scoreDetailsVC = storyboard.instantiateViewController(withIdentifier: Constants.scoreDetailsViewControllerName) as? ScoreDetailsViewController else { return }

        scoreViewModel.creditReportInfo.bind { [weak self] info in
            guard let scoreBand = info?.scoreBand,
                  let clientRef = info?.clientRef,
                  let status = info?.status,
                  let hasEverDefaulted = info?.hasEverDefaulted,
                  let percentageCreditUsed = info?.percentageCreditUsed else { return }

            scoreDetailsVC.scoreDetailsViewModel = ScoreDetailsViewModel(scoreBand: scoreBand,
                                                                         clientRef: clientRef,
                                                                         status: status,
                                                                         hasEverDefaulted: hasEverDefaulted,
                                                                         percentageCreditUsed: percentageCreditUsed)
            
            self?.navigationController?.pushViewController(scoreDetailsVC, animated: true)
        }
    }
}

