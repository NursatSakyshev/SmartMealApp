//
//  MainCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigateToTabBar()
    }
    
    func navigateToTabBar(){
        let tabBarVC = TabBarCoordinator(navigationController: navigationController)
        tabBarVC.start()
        childCoordinators.append(tabBarVC)
    }
}
