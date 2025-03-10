//
//  OnboardingViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 10.03.2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    var button: UIButton = {
        var button = UIButton()
        button.setTitle("done", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var onFinish: (() -> Void)?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "hello world"
        return label
    }()
    
    @objc func buttonTapped() {
        onFinish?()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
