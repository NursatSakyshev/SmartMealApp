//
//  ProfileCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

class ProfileCoordinator: NavigationCoordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileViewController()
        let viewModel = ProfileViewModel()
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
