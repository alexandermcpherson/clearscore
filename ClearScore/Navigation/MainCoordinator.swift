//
//  MainCoordinator.swift
//  ClearScore
//
//  Created by Alex McPherson on 31/03/2022.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ScoreViewController.instantiate()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func scoreInfo(scoreDetailsViewModel: ScoreDetailsViewModel) {
        let vc = ScoreDetailsViewController.instantiate()
        vc.scoreDetailsViewModel = scoreDetailsViewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
