//
//  ApiService.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class APIService {
    func getData(completion : @escaping ([[Recipe]]) -> ()) {
        completion([getRecommendations(), getPopular(), getQuickEasy(), getHealthy()])
    }
    
    func getRecommendations() -> [Recipe] {
        [
            Recipe.recipes[0], Recipe.recipes[4], Recipe.recipes[0], Recipe.recipes[1]
        ]
    }
    
    func getPopular() -> [Recipe] {
        [
            Recipe.recipes[0], Recipe.recipes[1]
        ]
    }
    
    func getQuickEasy() -> [Recipe] {
        Recipe.recipes
    }
    
    func getHealthy() -> [Recipe] {
        Recipe.recipes
    }
}

