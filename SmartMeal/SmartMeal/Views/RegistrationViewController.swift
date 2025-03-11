//
//  RegistrationViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.isHidden = true
        return view
    }()
    
    var viewModel: RegistrationViewModel!
    var coordinator: Coordinator?
    var login: (() -> ())?
    
    lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Full Name"
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
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter Email"
        return textField
    }()
    
    lazy var signInButton: CustomButton = {
        let button = CustomButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let signInText: UILabel = {
        let label = UILabel()
        label.text = "Do You Have An Account?"
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
        viewModel.isLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.loadingView.isHidden = false
                    self?.activityIndicator.startAnimating()
                }
                else {
                    self?.loadingView.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.onSuccess = { [weak self] in
            self?.login?()
        }
        viewModel.onError = {
            self.showAlert(message: "error")
        }
    }
    
    @objc func signInButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let fullName = nameTextField.text, !fullName .isEmpty else {
            return
        }
        
        viewModel.register(email: email, password: password)
    }
    
    func setupUI() {
        self.navigationItem.hidesBackButton = true
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(textButtonTapped), for: .touchUpInside)
        
        [welcomeLabel, imageView, emailTextField, nameTextField, passwordTextField, signInButton, divider, stackView, signInView, activityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        signInView.addArrangedSubview(signInText)
        signInView.addArrangedSubview(textButton)
        
        stackView.addArrangedSubview(googleIcon)
        stackView.addArrangedSubview(appleIcon)
        
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26),
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            nameTextField.heightAnchor.constraint(equalToConstant: 80),
            
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.heightAnchor.constraint(equalToConstant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26),
            passwordTextField.heightAnchor.constraint(equalToConstant: 80),
            
            signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            signInButton.heightAnchor.constraint(equalToConstant: 80),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            
            divider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            divider.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            appleIcon.heightAnchor.constraint(equalToConstant: 45),
            appleIcon.widthAnchor.constraint(equalToConstant: 45),
            
            googleIcon.heightAnchor.constraint(equalToConstant: 39),
            googleIcon.widthAnchor.constraint(equalToConstant: 39),
            
            stackView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension RegistrationViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @objc func textButtonTapped() {
        guard let coordinator = coordinator as? AuthCoordinator else { return }
        coordinator.goToLogin()
    }
}
 
