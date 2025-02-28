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
    let imageName: String?
    let ingridients: [Ingridient]
}

extension Recipe {
    static let recipes: [Recipe] = [
        Recipe(title: "Салат с авокадо", calories: 320, time: 25, description: "some description some description some description some description ", imageName: "salad", ingridients: [
            Ingridient(name: "Свекла", amount: 500, unit: "кг"),
            Ingridient(name: "Капуста", amount: 230, unit: "г"),
            Ingridient(name: "Морковь", amount: 150, unit: "кг"),
            Ingridient(name: "Кортофель", amount: 200, unit: "кг"),
            Ingridient(name: "Лук", amount: 100, unit: "кг"),
            Ingridient(name: "Томатная паста", amount: 50, unit: "мл"),
        ]),
        Recipe(title: "Паста с лососем", calories: 450, time: 40,description: "some description some description some description some description ", imageName: "pasta", ingridients: [
            Ingridient(name: "Свекла", amount: 500, unit: "кг"),
            Ingridient(name: "Капуста", amount: 230, unit: "г"),
            Ingridient(name: "Морковь", amount: 150, unit: "кг"),
            Ingridient(name: "Кортофель", amount: 200, unit: "кг"),
            Ingridient(name: "Лук", amount: 100, unit: "кг"),
            Ingridient(name: "Томатная паста", amount: 50, unit: "мл"),
        ]),
        Recipe(title: "Греческий салат", calories: 290, time: 20,description: "some description some description some description some description ", imageName: "greek", ingridients: [
            Ingridient(name: "Свекла", amount: 500, unit: "кг"),
            Ingridient(name: "Капуста", amount: 230, unit: "г"),
            Ingridient(name: "Морковь", amount: 150, unit: "кг"),
            Ingridient(name: "Кортофель", amount: 200, unit: "кг"),
            Ingridient(name: "Лук", amount: 100, unit: "кг"),
            Ingridient(name: "Томатная паста", amount: 50, unit: "мл"),
        ]),
        Recipe(title: "Куриное филе", calories: 520, time: 35,description: "some description some description some description some description ", imageName: "chicken", ingridients: [
            Ingridient(name: "Свекла", amount: 500, unit: "кг"),
            Ingridient(name: "Капуста", amount: 230, unit: "г"),
            Ingridient(name: "Морковь", amount: 150, unit: "кг"),
            Ingridient(name: "Кортофель", amount: 200, unit: "кг"),
            Ingridient(name: "Лук", amount: 100, unit: "кг"),
            Ingridient(name: "Томатная паста", amount: 50, unit: "мл"),
        ]),
        Recipe(title: "Паста с креветками", calories: 450, time: 30, description: "Вкусная паста с сочными креветками и сливочным соусом.", imageName: "pasta_shrimp", ingridients: [
            Ingridient(name: "Спагетти", amount: 200, unit: "г"),
            Ingridient(name: "Креветки", amount: 150, unit: "г"),
            Ingridient(name: "Чеснок", amount: 2, unit: "зубчика"),
            Ingridient(name: "Сливки", amount: 100, unit: "мл"),
            Ingridient(name: "Пармезан", amount: 50, unit: "г"),
            Ingridient(name: "Оливковое масло", amount: 20, unit: "мл"),
        ]),

        Recipe(title: "Смузи с бананом и ягодами", calories: 210, time: 10, description: "Освежающий и питательный ягодно-банановый смузи.", imageName: "smoothie", ingridients: [
            Ingridient(name: "Банан", amount: 1, unit: "шт"),
            Ingridient(name: "Клубника", amount: 100, unit: "г"),
            Ingridient(name: "Черника", amount: 50, unit: "г"),
            Ingridient(name: "Йогурт", amount: 150, unit: "мл"),
            Ingridient(name: "Мёд", amount: 10, unit: "мл"),
        ]),

        Recipe(title: "Омлет с грибами и сыром", calories: 320, time: 15, description: "Пышный омлет с шампиньонами и плавленым сыром.", imageName: "omelet", ingridients: [
            Ingridient(name: "Яйца", amount: 3, unit: "шт"),
            Ingridient(name: "Шампиньоны", amount: 100, unit: "г"),
            Ingridient(name: "Молоко", amount: 50, unit: "мл"),
            Ingridient(name: "Сыр", amount: 50, unit: "г"),
            Ingridient(name: "Масло сливочное", amount: 10, unit: "г"),
        ]),

        Recipe(title: "Греческий салат", calories: 270, time: 20, description: "Лёгкий и полезный салат с фетой и оливками.", imageName: "greek_salad", ingridients: [
            Ingridient(name: "Помидоры", amount: 200, unit: "г"),
            Ingridient(name: "Огурцы", amount: 150, unit: "г"),
            Ingridient(name: "Фета", amount: 100, unit: "г"),
            Ingridient(name: "Оливки", amount: 50, unit: "г"),
            Ingridient(name: "Красный лук", amount: 50, unit: "г"),
            Ingridient(name: "Оливковое масло", amount: 20, unit: "мл"),
            Ingridient(name: "Лимонный сок", amount: 10, unit: "мл"),
        ]),
    ]
}
