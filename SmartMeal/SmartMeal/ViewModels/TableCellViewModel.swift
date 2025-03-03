//
//  TableViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class TableCellViewModel {
    var collecionViewCellModels: [CollectionViewCellModel] = []
    var recipes: [Recipe]!
    
    init(recipes: [Recipe]) {
        print(recipes.count)
        self.recipes = recipes
        recipes.forEach {
            collecionViewCellModels.append(CollectionViewCellModel(recipe: $0))
        }
    }
    
    func recipeViewModel(at indexPath: IndexPath) -> CollectionViewCellModel {
        return self.collecionViewCellModels[indexPath.row]
    }
}
