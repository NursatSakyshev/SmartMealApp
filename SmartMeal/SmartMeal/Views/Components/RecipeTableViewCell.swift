//
//  RecipeCategoryCel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    var delegate: RecipeTableViewCellDelegate!
    
    var collectionView: UICollectionView!
    private var recipesViewModels: [CollectionCellViewModel] = []
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func recipeViewModel(at indexPath: IndexPath) -> CollectionCellViewModel {
        return self.recipesViewModels[indexPath.row]
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: .favoritesUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: .homeUpdated, object: nil)
    }
    
    @objc private func updateFavorites() {
        var indexPathsToReload: [IndexPath] = []
        
        for (index, viewModel) in recipesViewModels.enumerated() {
            let newValue = FavoritesManager.shared.isFavorite(viewModel.recipe)
            
            if viewModel.isFavorite.value != newValue {
                viewModel.isFavorite.value = newValue
                indexPathsToReload.append(IndexPath(item: index, section: 0))
            }
        }

        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: indexPathsToReload)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TableCellViewModel) {
        self.recipesViewModels = viewModel.collecionViewCellModels
        collectionView.reloadData()
    }

}

extension RecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesViewModels.count
    }
    
    override func prepareForReuse() {
    }
    
    func collectionView(_  collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        let viewModel = recipeViewModel(at: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = recipeViewModel(at: indexPath)
        delegate.didSelectRecipe(viewModel.recipe)
    }
}


protocol RecipeTableViewCellDelegate: AnyObject {
    func didSelectRecipe(_ recipe: Recipe)
}

extension RecipeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 160, height: 300)
    }
}
