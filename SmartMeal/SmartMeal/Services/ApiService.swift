//
//  ApiService.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation

class APIService {
    func getData(completion : @escaping ([[Recipe]]) -> ()) {
        let recommendations = getRecommendations()
          let popular = getPopular()
          let quickEasy = getQuickEasy()
          let healthy = getHealthy()
        
        completion([recommendations, popular, quickEasy, healthy])
    }
    
    func getRecommendations() -> [Recipe] {
        return Array(Recipe.recipes.prefix(2))
    }
    
    func getPopular() -> [Recipe] {
        return Array(Recipe.recipes.shuffled().prefix(5))  
    }
    
    func getQuickEasy() -> [Recipe] {
        return Array(Recipe.recipes.suffix(3))
    }
    
    func getHealthy() -> [Recipe] {
        Recipe.recipes
    }
}

