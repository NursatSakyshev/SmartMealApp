//
//  CollectionViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class CollectionCellViewModel {
    var recipe: Recipe!
    
    var didUpdate: (() -> Void)?
    
    init(recipe: Recipe) {
        self.recipe = recipe
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
    
    var isFavorite: Bool {
        return recipe.isFavorite
    }
    
    var imageUrl: String {
        return recipe.imageUrl!
    }
    
    func toggleFavorite() {
         recipe.isFavorite.toggle()
         didUpdate?()
     }
}
