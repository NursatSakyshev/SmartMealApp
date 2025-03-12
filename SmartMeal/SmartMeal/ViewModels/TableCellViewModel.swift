//
//  TableViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class TableCellViewModel {
    var collecionViewCellModels: [CollectionCellViewModel] = []
    var recipes: [Recipe]!
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
        recipes.forEach {
            collecionViewCellModels.append(CollectionCellViewModel(recipe: $0))
        }
    }
    
    func recipeViewModel(at indexPath: IndexPath) -> CollectionCellViewModel {
        return self.collecionViewCellModels[indexPath.row]
    }
}
