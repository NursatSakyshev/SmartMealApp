//
//  Recipe.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import Foundation

struct Recipe {
    let title: String
    let calories: Int
    let time: Int
    let description: String
    let imageName: String
}

extension Recipe {
    static let recipes: [Recipe] = [
        Recipe(title: "Салат с авокадо", calories: 320, time: 25, description: "some description some description some description some description ", imageName: "salad"),
        Recipe(title: "Паста с лососем", calories: 450, time: 40,description: "some description some description some description some description ", imageName: "pasta"),
        Recipe(title: "Греческий салат", calories: 290, time: 20,description: "some description some description some description some description ", imageName: "greek"),
        Recipe(title: "Куриное филе", calories: 520, time: 35,description: "some description some description some description some description ", imageName: "chicken"),
        Recipe(title: "Куриное филе", calories: 520, time: 35,description: "some description some description some description some description ", imageName: "chicken"),
        Recipe(title: "Куриное филе", calories: 520, time: 35,description: "some description some description some description some description ", imageName: "chicken"),
        Recipe(title: "Куриное филе", calories: 520, time: 35,description: "some description some description some description some description ", imageName: "chicken"),
        Recipe(title: "Паста с лососем", calories: 450, time: 40,description: "some description some description some description some description ", imageName: "pasta"),
    ]
}
