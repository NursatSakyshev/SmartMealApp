//
//  AuthCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 10.03.2025.
//

import Foundation
import UIKit

class AuthCoordinator: NavigationCoordinator {
    var navigationController: UINavigationController = UINavigationController()
    var window: UIWindow!
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    func start() {
        let vc = LoginViewController()
        vc.login = { [weak self] in
            self?.parentCoordinator?.start()
        }
        vc.coordinator = self
        let viewModel = LoginViewModel()
        vc.viewModel = viewModel
        navigationController.setViewControllers([vc], animated: false)
        window.rootViewController = navigationController
    }
    
    func goToLogin() {
        navigationController.popViewController(animated: true)
    }
    
    func goToRegister() {
        let vc = RegistrationViewController()
        vc.login = { [weak self] in
            self?.parentCoordinator?.start()
        }
        vc.coordinator = self
        let viewModel = RegistrationViewModel()
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
