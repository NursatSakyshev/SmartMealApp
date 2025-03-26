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
    
    var dishType: String {
        return recipe.dishType
    }
    
    var cuisine: String {
        return recipe.cuisine
    }
    
    var steps: [Step] {
//        return recipe.steps
        return [
            Step(text: "Мелко нарежьте лук и смешайте с фаршем в кастрюле с толстым дном. Влейте ложку оливкового масла и жарьте на среднем огне пока фарш поменяет цвет.", imageURL: "asdf", stepNumber: "Шаг 1 из 8"),
            Step(text: "Морковь нарежьте мелким кубиком и перемешивая, готовьте еще пару минут.", imageURL: "asdf", stepNumber: "Шаг 1 из 8"),
            Step(text: "Нарежьте помидоры и стебли петрушки и жарьте еще две минуты.", imageURL: "asdf", stepNumber: "3/1"),
            Step(text: "Залейте водой все содержимое, доведите до кипения и варите минут пять.", imageURL: "asdf", stepNumber: "Шаг 1 из 8"),
            Step(text: "Доведите суп до кипения и варите три минуты. Посолите, поперчите и добавьте итальянские травы. Снимите с плиты и дайте супу настояться 15 минут.", imageURL: "asdf", stepNumber: "Шаг 1 из 8"),
        ]
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
