//
//  HomeCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        let viewModel = HomeViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
}
