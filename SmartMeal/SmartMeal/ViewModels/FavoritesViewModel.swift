//
//  FavoritesViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 04.03.2025.
//

import Foundation

class FavoritesViewModel {
    private let favoritesManager = FavoritesManager.shared
    var collectionCellViewModels: Dynamic<[CollectionCellViewModel]> = Dynamic([])
    var favoriteRecipes: [Recipe] = []
    
    func getCollectionCellViewModel(at indexPath: IndexPath) -> CollectionCellViewModel {
        return self.collectionCellViewModels.value[indexPath.row]
     }
    
    var onFavoritesUpdated: (() -> Void)?
    
    init() {
        loadFavorites()
        FavoritesManager.shared.onFavoritesUpdated = { [weak self] in
            self?.loadFavorites()
        }
    }
    
    func loadFavorites() {
        favoriteRecipes = favoritesManager.getFavorites()
        collectionCellViewModels.value = favoriteRecipes.map { CollectionCellViewModel(recipe: $0) }
        print(favoriteRecipes.count)
        onFavoritesUpdated?()
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        favoritesManager.removeFromFavorites(recipe)
        favoriteRecipes.removeAll { recipe in
            recipe.title == recipe.title
        }
        print(favoriteRecipes.count)
        loadFavorites()
    }
}
