//
//  AppDelegate.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = navController
        return true
    }
    
}

