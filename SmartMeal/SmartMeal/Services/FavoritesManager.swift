//
//  FavoritesManager.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 04.03.2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
    static let homeUpdated = Notification.Name("homeUpdated")
}


class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoriteRecipes"
    let db = Firestore.firestore()
    var onFavoritesUpdated: (() -> Void)?
    
    private init() {
        Task {
            await syncFavorites()
            NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
            onFavoritesUpdated?()
        }
    }

    //User Defaults
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.title == recipe.title }
    }
    
    func getFavorites() -> [Recipe] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let recipes = try? JSONDecoder().decode([Recipe].self, from: data) else {
            return []
        }
        return recipes
    }

    private func saveFavorites(_ recipes: [Recipe]) {
        if let data = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }

    func addToFavorites(_ recipe: Recipe) {
        var favorites = getFavorites()
        favorites.append(recipe)
        saveFavorites(favorites)
        Task {
            await saveFavorite(recipe)
        }
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        onFavoritesUpdated?()
    }

    
    func removeFromFavorites(_ recipe: Recipe) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == recipe.id }
        saveFavorites(favorites)

        Task {
            await removeFavorite(recipe)
        }

        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        onFavoritesUpdated?()
    }

    func syncFavorites() async {
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/saved-recipes/") else {
            print("url error")
            return  }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return  }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                print("get fav error")
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
                    parsedIngredients.append(APIService.shared.parseIngredient(from: ingredient))
                }
                
                let recipe = Recipe(
                    id: id, title: title, calories: calories, time: time,
                    description: description, imageUrl: imageUrl,
                    ingridients: parsedIngredients, dishType: dishType, cuisine: cuisine, steps: []
                )
                
                loadedRecipes.append(recipe)
            }
            print("success")
            saveFavorites(loadedRecipes)
        } catch {
            print("Ошибка при парсинге данных: \(error)")
            return
        }
    }
    
    private func saveFavorite(_ recipe: Recipe) async {
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/saved-recipes/") else {
            return
        }
        
        var request = URLRequest(url: url)
        let body: [String: Any] = ["recipe_id": recipe.id]
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        performAuthorizedRequest(url: url, method: "POST", body: jsonData) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("saved successfully")
            } else {
                print("save fav: error")
            }
        }
    }

    
    private func removeFavorite(_ recipe: Recipe) async {
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/saved-recipes/") else {
            return
        }
        
        var request = URLRequest(url: url)
        let body: [String: Any] = ["recipe_id": recipe.id]
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        performAuthorizedRequest(url: url, method: "DELETE", body: jsonData) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("deleted successfully")
            } else {
                print("delete fav: error")
            }
        }
    }
    
    func performAuthorizedRequest(url: URL, method: String, body: Data? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            completion(nil, nil, NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No access token"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                APIService.shared.refreshAccessToken { success in
                    if success {
                        self.performAuthorizedRequest(url: url, method: method, body: body, completion: completion)
                    } else {
                        completion(nil, response, NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Failed to refresh token"]))
                    }
                }
            } else {
                completion(data, response, error)
            }
        }
        
        task.resume()
    }

}




