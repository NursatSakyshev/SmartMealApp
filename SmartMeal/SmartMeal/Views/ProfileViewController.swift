//
//  ProfileViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import UIKit
import SkeletonView

class ProfileViewController: UIViewController, Coordinated {
    weak var coordinator: Coordinator?
    var viewModel: ProfileViewModel!
    
    var signOut: (() -> ())?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileViewCell.self, forCellReuseIdentifier: "ProfileViewCell")

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let profileView: UIView = {
        let view = RoundedView()
        view.backgroundColor = .white
        return view
    }()
    
    func setupBindings() {
        viewModel.fullName.bind({ [weak self] fullName in
            self?.nameLabel.text = fullName
        })
        
        viewModel.email.bind({ [weak self] email in
            self?.emailLabel.text = email
        })
        
        viewModel.fetchUserData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        setupUI()
        setupBindings()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameLabel.showSkeleton(usingColor: .lightGray, transition: .crossDissolve(0.25))
    }
    
    func setupUI() {
        [profileView, profileImageView, emailLabel, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            profileView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 350),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as? ProfileViewCell else { return UITableViewCell() }
        cell.configure(title: "sign out")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.removeObject(forKey: "authToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        signOut?()
    }
}
