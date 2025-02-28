//
//  CollectionViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class CollectionViewCellModel {
    var recipe: Recipe!
    
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
}
