//
//  MainCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

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
        navigateToTabBar()
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
