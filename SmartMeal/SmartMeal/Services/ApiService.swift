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
        fetchRandomRecipes(url: "https://api.smartmeal.kz/v1/food/recipes/random") { recipes in
            completion(recipes)
        }
    }
    
    func getPopular(completion: @escaping ([Recipe]) -> Void) {
        fetchRecipes(url: "https://api.smartmeal.kz/v1/food/recipes/popular") { recipes in
            completion(recipes)
        }
    }
    
    
    func getQuickEasy(completion: @escaping ([Recipe]) -> Void) {
        fetchRandomRecipes(url: "https://api.smartmeal.kz/v1/food/recipes/random") { recipes in
            completion(recipes)
        }
    }
    
    func getHealthy(completion: @escaping ([Recipe]) -> Void) {
        fetchRandomRecipes(url: "https://api.smartmeal.kz/v1/food/recipes/random") { recipes in
            completion(recipes)
        }
    }
    
    func saveFavoriteRecipe(userId: String, recipe: Recipe) {
//        let db = Firestore.firestore()
//        let favoritesRef = db.collection("users").document(userId).collection("favorites").document(recipe.id)
//        
//        addRecipe(reference: favoritesRef, recipe: recipe)
    }
    
    func getFavoriteRecipes(userId: String) async -> [Recipe] {
//        let favoritesRef = db.collection("users").document(userId).collection("favorites")
//        return await getRecipes(collection: favoritesRef)
        return []
    }
    
    func fetchRecipes(url: String, completion: @escaping ([Recipe]) -> Void) {
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Нет данных в ответе")
                completion([])
                return
            }
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion([])
                    return
                }
                
                var loadedRecipes = [Recipe]()
                
                if let results = json["results"] as? [[String: Any]] {
                    for recipe in results {
                        let id = recipe["id"] as? Int ?? 0
                        let title = recipe["name"] as? String ?? ""
                        let calories = recipe["calories"] as? Int ?? 0
                        let time = recipe["cooking_time"] as? String ?? "0"
                        let description = recipe["description"] as? String ?? ""
                        let imageUrl = recipe["img_url"] as? String
                        let dishType = recipe["dish_type"] as? String ?? ""
                        let cuisine = recipe["cuisine"] as? String ?? ""
                        
                        var parsedIngredients = [Ingredient]()
                        let ingredients = recipe["ingredients"] as? [String] ?? []
                        for ingredient in ingredients {
                            parsedIngredients.append(self.parseIngredient(from: ingredient))
                        }
                        
                        let recipe = Recipe(id: id, title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: parsedIngredients, dishType: dishType, cuisine: cuisine, steps: [])
                        
                        loadedRecipes.append(recipe)
                    }
                } else {
                    print("Не удалось получить рецепты")
                }
                completion(loadedRecipes)
            }
            catch {
                
            }
            
        }.resume()
    }
    
    func fetchRandomRecipes(url: String, completion: @escaping ([Recipe]) -> Void) {
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Нет данных в ответе")
                completion([])
                return
            }
            
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var loadedRecipes = [Recipe]()
                
                for recipe in json {
                    let id = recipe["id"] as? Int ?? 0
                    let title = recipe["name"] as? String ?? ""
                    let calories = recipe["calories"] as? Int ?? 0
                    let time = recipe["cooking_time"] as? String ?? "0"
                    let description = recipe["description"] as? String ?? ""
                    let imageUrl = recipe["img_url"] as? String
                    let dishType = recipe["dish_type"] as? String ?? ""
                    let rating = recipe["rating"] as? String ?? ""
                    let cuisine = recipe["cuisine"] as? String ?? ""
                    
                    var parsedIngredients = [Ingredient]()
                    let ingredients = recipe["ingredients"] as? [String] ?? []
                    for ingredient in ingredients {
                        parsedIngredients.append(self.parseIngredient(from: ingredient))
                    }
                    
                    let recipe = Recipe(id: id, title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: parsedIngredients, dishType: dishType, cuisine: cuisine, steps: [])
                    
                    loadedRecipes.append(recipe)
                }
                
                completion(loadedRecipes)
            } catch {
                print("Ошибка при парсинге данных: \(error)")
            }
        }.resume()
    }
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken"),
              let url = URL(string: "https://api.smartmeal.kz/v1/auth/token/refresh/") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["refresh": refreshToken]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let newAccessToken = json["access"] as? String {
                    UserDefaults.standard.set(newAccessToken, forKey: "authToken")
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }
        
        task.resume()
    }
    
    func validateToken(completion: @escaping (Bool) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "https://api.smartmeal.kz/v1/auth/me/") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(true)
                } else if httpResponse.statusCode == 401 {
                    self.refreshAccessToken { isRefreshed in
                        if isRefreshed {
                            self.validateToken(completion: completion)
                        } else {
                            DispatchQueue.main.async {
                                UserDefaults.standard.removeObject(forKey: "authToken")
                                UserDefaults.standard.removeObject(forKey: "refreshToken")
                            }
                            completion(false)
                        }
                    }
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        
        task.resume()
    }
    
    func saveToken(access: String, refresh: String) {
        UserDefaults.standard.set(access, forKey: "authToken")
        UserDefaults.standard.set(refresh, forKey: "refreshToken")
    }
    
    func parseIngredient(from text: String) -> Ingredient {
        let parts = text.split(separator: "(")
        let name = parts.first
        let amount = parts.last?.dropLast()
        return Ingredient(name: "\(name!)", amount: "\(amount!)")
    }
}



