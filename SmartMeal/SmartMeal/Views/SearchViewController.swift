//
//  SearchViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import UIKit

class SearchViewController: UIViewController, Coordinated {
    weak var coordinator: Coordinator?
    var collectionView: UICollectionView!
    var viewModel: SearchViewModel!
    
    let recommendationLabel: UILabel = {
        let label = UILabel()
        label.text = "For You"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        return label
    }()
    
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
            collectionView.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupCollectionView()
    }
    
    func setupUI() {
        [searchField, recommendationLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            recommendationLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 40),
            recommendationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
}
