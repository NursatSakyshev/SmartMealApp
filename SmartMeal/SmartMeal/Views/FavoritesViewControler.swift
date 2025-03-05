//
//  SavedViewControler.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import Foundation

import UIKit

class FavoritesViewController: UIViewController, Coordinated {
    weak var coordinator: Coordinator?
    var viewModel: FavoritesViewModel!
    
    var collectionView: UICollectionView!
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
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
        setupCollectionView()
        bindViewModel()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc private func reloadFavorites() {
        viewModel.loadFavorites()
    }
    
    private func bindViewModel() {
        viewModel.collectionCellViewModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.collectionCellViewModels.value.count
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
        guard let coordinator = coordinator as? FavoritesCoordinator else {
            return
        }
        coordinator.showDetail(for: viewModel.recipe)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width/2)
        return CGSize(width: size - 15, height: 300)
    }
}
