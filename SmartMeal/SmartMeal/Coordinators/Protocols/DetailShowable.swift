//
//  DetailShowable.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 03.03.2025.
//

import Foundation
import UIKit

protocol DetailShowable {
    func showDetail(for recipe: Recipe)
}

extension DetailShowable where Self: NavigationCoordinator {
    func showDetail(for recipe: Recipe) {
        let detailVC = DetailViewController()
        detailVC.viewModel = DetailViewModel(recipe: recipe)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
