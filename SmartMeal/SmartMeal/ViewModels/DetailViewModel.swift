//
//  DetailViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import Foundation
import UIKit

class DetailViewModel {
    var recipe: Recipe
    
    var ingridients: [Ingredient] {
        return recipe.ingridients
    }
    
    var time: String {
        return recipe.time
    }
    
    var difficulty: String {
        return recipe.difficulty
    }
    
    var servings: Int {
        return recipe.servings
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
