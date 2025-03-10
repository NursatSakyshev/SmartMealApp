//
//  AuthCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 10.03.2025.
//

import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    var window: UIWindow!
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    func start() {
        let vc = RegistrationViewController()
        let viewModel = RegistrationViewModel()
        vc.viewModel = viewModel
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
