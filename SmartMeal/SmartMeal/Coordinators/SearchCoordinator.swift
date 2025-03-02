//
//  SearchCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

class SearchCoordinator: NavigationCoordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    func start() {
        let vc = SearchViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
