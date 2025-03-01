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
    
    var ingridients: [Ingridient] {
        return recipe.ingridients
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
