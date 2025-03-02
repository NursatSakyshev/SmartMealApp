//
//  NavigatorCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 02.03.2025.
//


import UIKit
protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
