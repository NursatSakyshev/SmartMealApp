//
//  HomeViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import Foundation

class HomeViewModel {
    var recipes: [Recipe] = []
    
    func fetchRecipes(completion: @escaping () -> Void) {
        // Здесь загружаешь рецепты из API или базы данных
        self.recipes = Recipe.recipes
        completion()
    }
}
