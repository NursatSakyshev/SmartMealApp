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
    let tabBarVC = TabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarVC
        return true
    }

}

