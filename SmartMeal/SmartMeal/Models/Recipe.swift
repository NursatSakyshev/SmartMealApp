//
//  Recipe.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String
    let calories: Int
    let time: String
    let description: String
    let imageUrl: String?
    let ingridients: [Ingredient]
    let dishType: String
    let cuisine: String
    let steps: [Step]
}
