//
//  TestViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 21.03.2025.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = "DELICOUS FOOD"
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Healthy food is food that gives you all the nutrients you need to stay healthy, feel well and have plenty of energy"
        return label
    }()
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboarding3")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        [imageView, mainLabel, subLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
        ])
    }
}
