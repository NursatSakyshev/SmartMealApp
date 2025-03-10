//
//  LoginViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    var coordinator: Coordinator?
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter Username Or Email"
        return textField
    }()
    
    lazy var appleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageAssets.apple)
        return imageView
    }()
    
    lazy var googleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageAssets.google)
        return imageView
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    lazy var signInButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        return button
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 80
        return stackView
    }()
    
    lazy var signInView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var textButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register Now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let signInText: UILabel = {
        let label = UILabel()
        label.text = "Not A Member?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
        
    }()
    let divider = DividerView(text: "Or", lineColor: .lightGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onSuccess = { [weak self] in
            print("Вход успешен!")
        }
        viewModel.onError = { errorMessage in
            print("Ошибка: \(errorMessage)")
        }
    }
    
    func setupUI() {
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
        [welcomeLabel, emailTextField, passwordTextField, signInButton, divider, stackView, signInView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        signInView.addArrangedSubview(signInText)
        signInView.addArrangedSubview(textButton)
        
        stackView.addArrangedSubview(googleIcon)
        stackView.addArrangedSubview(appleIcon)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26),
            emailTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26),
            passwordTextField.heightAnchor.constraint(equalToConstant: 80),
            
            signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            signInButton.heightAnchor.constraint(equalToConstant: 80),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            
            divider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            divider.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 60),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            appleIcon.heightAnchor.constraint(equalToConstant: 45),
            appleIcon.widthAnchor.constraint(equalToConstant: 45),
            
            googleIcon.heightAnchor.constraint(equalToConstant: 39),
            googleIcon.widthAnchor.constraint(equalToConstant: 39),
            
            stackView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 60),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
}

extension LoginViewController {
    @objc func signIn(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        viewModel.login(email: email, password: password)
    }
    
    @objc func textButtonTapped() {
        guard let coordinator = coordinator as? AuthCoordinator else { return }
        coordinator.goToRegister()
    }
}
