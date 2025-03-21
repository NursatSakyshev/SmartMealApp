//
//  OnboardingCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 10.03.2025.
//

import Foundation
import UIKit
import SwiftUI

class OnboardingCoordinator: Coordinator {
    var window: UIWindow!
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    func start() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.onFinish = { [weak self] in
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            self?.parentCoordinator?.start()
        }
        window.rootViewController = onboardingVC
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
