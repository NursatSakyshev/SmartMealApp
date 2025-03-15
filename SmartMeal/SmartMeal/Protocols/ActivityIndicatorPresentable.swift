//
//  ActivityIndicatorPresentable.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 15.03.2025.
//

import Foundation
import UIKit

protocol ActivityIndicatorPresentable: AnyObject {
    var activityIndicator: UIActivityIndicatorView { get }
    
    func setupActivityIndicator()
    func showLoading(_ isLoading: Bool)
}

extension ActivityIndicatorPresentable where Self: UIViewController {
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

