//
//  Coordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
