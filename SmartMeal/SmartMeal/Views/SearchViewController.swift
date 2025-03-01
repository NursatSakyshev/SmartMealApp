//
//  SearchViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import UIKit

class SearchViewController: UIViewController, Coordinated {
    weak var coordinator: Coordinator?
    
    lazy var searchField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = "Enter products"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        [searchField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            searchField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
