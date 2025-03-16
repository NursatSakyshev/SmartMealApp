//
//  SearchViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import UIKit

class SearchViewController: UIViewController, Coordinated, ActivityIndicatorPresentable {
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    weak var coordinator: Coordinator?
    var collectionView: UICollectionView!
    var viewModel: SearchViewModel!
    
    lazy var searchField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = "Enter products"
        return textField
    }()
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupCollectionView()
        setupActivityIndicator()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRecipes), name: .favoritesUpdated, object: nil)
        
        viewModel.popularRecipes.bind { _ in
            self.reloadRecipes()
        }
        
        viewModel.isLoading = { [weak self] isLoading in
            self?.showLoading(isLoading)
        }
        
        viewModel.callFuncToGetData()
    }
    
    @objc private func reloadRecipes() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    func setupUI() {
        activityIndicator.hidesWhenStopped = true
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionCellViewModels.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        let viewModel = viewModel.getCollectionCellViewModel(at: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModel.getCollectionCellViewModel(at: indexPath)
        guard let coordinator = coordinator as? SearchCoordinator else {
            return
        }
        coordinator.showDetail(for: viewModel.recipe)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width/2)
        return CGSize(width: size - 15, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
              return header
          }
          return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
