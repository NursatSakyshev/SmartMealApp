//
//  HomeViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

class HomeViewController: UIViewController, ActivityIndicatorPresentable {
    var activityIndicator = UIActivityIndicatorView(style: .large)

    var viewModel: HomeViewModel!
    weak var coordinator: Coordinator?
    
    private func bindViewModel() {
        viewModel.isLoading = { [weak self] isLoading in
            self?.showLoading(isLoading)
        }
        
        viewModel.bind = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.callFuncToGetData()
    }
    
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
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCategoryCell")

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        setupActivityIndicator()
        bindViewModel()
    }
        
    func setupUI() {
        view.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource, RecipeTableViewCellDelegate {
    func didSelectRecipe(_ recipe: Recipe) {
        guard let coordinator = coordinator as? HomeCoordinator else {
            return
        }
        coordinator.showDetail(for: recipe)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCategoryCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let viewModel = viewModel.getTableCellModel(at: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.isUserInteractionEnabled = true
        
        let label = UILabel()
        label.text = viewModel.categories?[section]
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

