//
//  CollectionViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class CollectionCellViewModel {
    private var favoritesManager = FavoritesManager.shared
    var recipe: Recipe! 
    var isFavorite: Dynamic<Bool>
    
    init(recipe: Recipe) {
        self.recipe = recipe
        isFavorite = Dynamic(favoritesManager.isFavorite(recipe))
    }
    
    func toggleFavorite() {
        if isFavorite.value {
            favoritesManager.removeFromFavorites(recipe)
        } else {
            favoritesManager.addToFavorites(recipe)
        }
        
        isFavorite.value = favoritesManager.isFavorite(recipe)
    }
    
    var name: String {
        return recipe.title
    }
    
    var calories: Int {
        return recipe.calories
    }
    
    var time: Int {
        return recipe.time
    }
    
    var imageUrl: String {
        return recipe.imageUrl!
    }
}
