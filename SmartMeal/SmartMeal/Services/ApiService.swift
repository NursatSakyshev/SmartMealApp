//
//  ApiService.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation
import UIKit
import FirebaseFirestore

class APIService {
    static let shared = APIService()
    private let db = Firestore.firestore()
    func getRecommendations(completion: @escaping ([Recipe]) -> Void) {
        db.collection("recipes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка загрузки: \(error.localizedDescription)")
                return
            }
            
            var loadedRecipes: [Recipe] = []
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot!.documents {
                dispatchGroup.enter()
                let data = document.data()
                
                let title = data["title"] as? String ?? ""
                let calories = data["calories"] as? Int ?? 0
                let time = data["time"] as? Int ?? 0
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String
                let difficulty = data["difficulty"] as? String ?? ""
                let servings = data["servings"] as? Int ?? 0
                
                var ingredients: [Ingridient] = []
                
                
                self.db.collection("recipes").document(document.documentID).collection("ingredients").getDocuments { (ingredientSnapshot, error) in
                    if let ingredientSnapshot = ingredientSnapshot {
                        for ingredientDoc in ingredientSnapshot.documents {
                            let ingredientData = ingredientDoc.data()
                            let name = ingredientData["name"] as? String ?? ""
                            let amount = ingredientData["amount"] as? Int ?? 0
                            let unit = ingredientData["unit"] as? String ?? ""
                            let ingredient = Ingridient(name: name, amount: amount, unit: unit)
                            ingredients.append(ingredient)
                        }
                    }
                    let recipe = Recipe(title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: ingredients, difficulty: difficulty, servings: servings)
                    loadedRecipes.append(recipe)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                completion(Array(loadedRecipes.prefix(3)))
            }
        }
    }
    
    private let imageCache = NSCache<NSString, NSData>()
    
    func getPopular(completion: @escaping ([Recipe]) -> Void) {
        db.collection("recipes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка загрузки: \(error.localizedDescription)")
                return
            }
            
            var loadedRecipes: [Recipe] = []
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot!.documents {
                dispatchGroup.enter()
                let data = document.data()
                
                let title = data["title"] as? String ?? ""
                let calories = data["calories"] as? Int ?? 0
                let time = data["time"] as? Int ?? 0
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String
                let difficulty = data["difficulty"] as? String ?? ""
                let servings = data["servings"] as? Int ?? 0
                
                var ingredients: [Ingridient] = []
                
                
                self.db.collection("recipes").document(document.documentID).collection("ingredients").getDocuments { (ingredientSnapshot, error) in
                    if let ingredientSnapshot = ingredientSnapshot {
                        for ingredientDoc in ingredientSnapshot.documents {
                            let ingredientData = ingredientDoc.data()
                            let name = ingredientData["name"] as? String ?? ""
                            let amount = ingredientData["amount"] as? Int ?? 0
                            let unit = ingredientData["unit"] as? String ?? ""
                            let ingredient = Ingridient(name: name, amount: amount, unit: unit)
                            ingredients.append(ingredient)
                        }
                    }
                    let recipe = Recipe(title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: ingredients, difficulty: difficulty, servings: servings)
                    loadedRecipes.append(recipe)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                completion(Array(loadedRecipes.dropFirst(3).prefix(3)))
            }
        }
    }
    
    func getQuickEasy(completion: @escaping ([Recipe]) -> Void) {
        db.collection("recipes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка загрузки: \(error.localizedDescription)")
                return
            }
            
            var loadedRecipes: [Recipe] = []
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot!.documents {
                dispatchGroup.enter()
                let data = document.data()
                
                let title = data["title"] as? String ?? ""
                let calories = data["calories"] as? Int ?? 0
                let time = data["time"] as? Int ?? 0
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String
                let difficulty = data["difficulty"] as? String ?? ""
                let servings = data["servings"] as? Int ?? 0
                
                var ingredients: [Ingridient] = []
                
                
                self.db.collection("recipes").document(document.documentID).collection("ingredients").getDocuments { (ingredientSnapshot, error) in
                    if let ingredientSnapshot = ingredientSnapshot {
                        for ingredientDoc in ingredientSnapshot.documents {
                            let ingredientData = ingredientDoc.data()
                            let name = ingredientData["name"] as? String ?? ""
                            let amount = ingredientData["amount"] as? Int ?? 0
                            let unit = ingredientData["unit"] as? String ?? ""
                            let ingredient = Ingridient(name: name, amount: amount, unit: unit)
                            ingredients.append(ingredient)
                        }
                    }
                    let recipe = Recipe(title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: ingredients, difficulty: difficulty, servings: servings)
                    loadedRecipes.append(recipe)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                completion(Array(loadedRecipes.dropFirst(6).prefix(3)))
            }
        }
    }
    
    func getHealthy(completion: @escaping ([Recipe]) -> Void) {
        db.collection("recipes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Ошибка загрузки: \(error.localizedDescription)")
                return
            }
            
            var loadedRecipes: [Recipe] = []
            let dispatchGroup = DispatchGroup()
            
            for document in snapshot!.documents {
                dispatchGroup.enter()
                let data = document.data()
                
                let title = data["title"] as? String ?? ""
                let calories = data["calories"] as? Int ?? 0
                let time = data["time"] as? Int ?? 0
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String
                let difficulty = data["difficulty"] as? String ?? ""
                let servings = data["servings"] as? Int ?? 0
                
                var ingredients: [Ingridient] = []
                
                
                self.db.collection("recipes").document(document.documentID).collection("ingredients").getDocuments { (ingredientSnapshot, error) in
                    if let ingredientSnapshot = ingredientSnapshot {
                        for ingredientDoc in ingredientSnapshot.documents {
                            let ingredientData = ingredientDoc.data()
                            let name = ingredientData["name"] as? String ?? ""
                            let amount = ingredientData["amount"] as? Int ?? 0
                            let unit = ingredientData["unit"] as? String ?? ""
                            let ingredient = Ingridient(name: name, amount: amount, unit: unit)
                            ingredients.append(ingredient)
                        }
                    }
                    let recipe = Recipe(title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: ingredients, difficulty: difficulty, servings: servings)
                    loadedRecipes.append(recipe)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                completion(Array(loadedRecipes.suffix(3)))
            }
        }
    }
    
    func fetchImageData(from url: String, completion: @escaping (Data?) -> Void) {
        let key = url as NSString
        
        if let cachedData = imageCache.object(forKey: key) {
            completion(cachedData as Data)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        db.collection("recipes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching recipes: \(error)")
                completion([])
                return
            }
            
            var recipes: [Recipe] = []
            for document in snapshot?.documents ?? [] {
                let data = document.data()
                let recipe = Recipe(
                    title: data["title"] as? String ?? "",
                    calories: data["calories"] as? Int ?? 0,
                    time: data["time"] as? Int ?? 0,
                    description: data["description"] as? String ?? "",
                    imageUrl: data["imageUrl"] as? String,
                    ingridients: [],
                    difficulty: data["difficulty"] as? String ?? "",
                    servings: data["servings"] as? Int ?? 1
                )
                recipes.append(recipe)
            }
            
            completion(recipes)
        }
    }
    
    func fetchIngredients(for recipeId: String, completion: @escaping ([Ingridient]) -> Void) {
        db.collection("recipes").document(recipeId).collection("ingredients").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching ingredients: \(error)")
                completion([])
                return
            }
            
            var ingredients: [Ingridient] = []
            for document in snapshot?.documents ?? [] {
                let data = document.data()
                let ingredient = Ingridient(
                    name: data["name"] as? String ?? "",
                    amount: data["amount"] as? Int ?? 0,
                    unit: data["unit"] as? String ?? ""
                )
                ingredients.append(ingredient)
            }
            
            completion(ingredients)
        }
    }
    
    func addRecipe(recipe: Recipe) {
        var recipeRef: DocumentReference? = nil
        recipeRef = db.collection("recipes").addDocument(data: [
            "title": recipe.title,
            "calories": recipe.calories,
            "time": recipe.time,
            "description": recipe.description,
            "imageUrl": recipe.imageUrl ?? "",
            "difficulty": recipe.difficulty,
            "servings": recipe.servings
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(recipeRef!.documentID)")
                for ingredient in recipe.ingridients {
                    recipeRef?.collection("ingredients").addDocument(data: [
                        "name": ingredient.name,
                        "amount": ingredient.amount,
                        "unit": ingredient.unit
                    ])
                }
            }
        }
    }
    
    //    func fetchRecipesWithIngredients(completion: @escaping ([Recipe]) -> Void) {
    //        fetchRecipes { recipes in
    //            var updatedRecipes = recipes
    //            let dispatchGroup = DispatchGroup()
    //
    //            for (index, recipe) in recipes.enumerated() {
    //                dispatchGroup.enter()
    //                fetchIngredients(for: recipe.id) { ingredients in
    //                    updatedRecipes[index].ingridients = ingredients
    //                    dispatchGroup.leave()
    //                }
    //            }
    //
    //            dispatchGroup.notify(queue: .main) {
    //                completion(updatedRecipes)
    //            }
    //        }
    //    }
}

