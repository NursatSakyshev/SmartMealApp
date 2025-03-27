//
//  MainCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit
import FirebaseAuth

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var window: UIWindow!
    var navigationController: UINavigationController
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func start() {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        let token = UserDefaults.standard.string(forKey: "authToken")
//        UserDefaults.standard.set(nil, forKey: "authToken")
        
        if !hasSeenOnboarding {
            showOnboardingScreen()
        } else if token == nil {
            showAuth()
        } else {
            navigateToTabBar()
            APIService.shared.validateToken { isValid in
                DispatchQueue.main.async {
                    if !isValid {
                        self.showAuth()
                    }
                }
            }
        }
        
        
//        if token == nil {
//            showAuth()
//        } else {
//            navigateToTabBar()
//            APIService.shared.validateToken { isValid in
//                DispatchQueue.main.async {
//                    if !isValid {
//                        self.showAuth()
//                    }
//                }
//            }
//        }
    }
    
    func showAuth() {
        let authVC = AuthCoordinator(window: window)
        authVC.parentCoordinator = self
        authVC.start()
        childCoordinators.append(authVC)
    }
    
    func showOnboardingScreen() {
        let onboardingVC = OnboardingCoordinator(window: window)
        onboardingVC.parentCoordinator = self
        onboardingVC.start()
        childCoordinators.append(onboardingVC)
    }
    
    func navigateToTabBar(){
        let tabBarVC = TabBarCoordinator(window: window)
        tabBarVC.start()
        childCoordinators.append(tabBarVC)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let coordinatedVC = fromViewController as? UIViewController & Coordinated {
            removeChild(coordinatedVC.coordinator)
        }
    }
    
    func removeChild(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        childCoordinators.removeAll { $0 === coordinator }
    }
}
