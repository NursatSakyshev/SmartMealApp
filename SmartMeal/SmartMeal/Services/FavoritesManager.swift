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
            await syncFavoritesFromFirebase()
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
            await saveFavoriteToFirebase(recipe)
        }
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        onFavoritesUpdated?()
    }

    
    func removeFromFavorites(_ recipe: Recipe) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == recipe.id }
        saveFavorites(favorites)

        Task {
            await removeFavoriteFromFirebase(recipe)
        }

        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        onFavoritesUpdated?()
    }

    func syncFavoritesFromFirebase() async {
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
                print("error")
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
    
    private func saveFavoriteToFirebase(_ recipe: Recipe) async {
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/saved-recipes/") else {
            return
        }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let body: [String: Any] = ["recipe_id": recipe.id]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            print("Рецепт  успешно добавлен в избранное")
        }
        catch {
            
        }
    }

    
    private func removeFavoriteFromFirebase(_ recipe: Recipe) async {
        print("")
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/saved-recipes/") else {
            return
        }
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            return
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        do {
            let body: [String: Any] = ["recipe_id": recipe.id]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("delete error1")
                return
            }
            print("Рецепт успешно удален из избранного")
        }
        catch {
            print("delete error2")
        }

    }
}




