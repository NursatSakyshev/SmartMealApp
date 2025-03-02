//
//  HomeCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

class HomeCoordinator: NavigationCoordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        let viewModel = HomeViewModel()
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func showDetail(for recipe: Recipe) {
        let detailVC = DetailViewController()
        detailVC.viewModel = DetailViewModel(recipe: recipe)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
