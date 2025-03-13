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
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let remoteFavorites = await fetchFavoritesFromFirebase(userId: userId)
        saveFavorites(remoteFavorites)
    }
    
    private func fetchFavoritesFromFirebase(userId: String) async -> [Recipe] {
        var favoriteRecipes: [Recipe] = []

        favoriteRecipes = await APIService.shared.getFavoriteRecipes(userId: userId)
        return favoriteRecipes
    }
    
    private func saveFavoriteToFirebase(_ recipe: Recipe) async {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        do {
            let recipeData: [String: Any] = [
                "id": recipe.id,
                "title": recipe.title,
                "calories": recipe.calories,
                "time": recipe.time,
                "description": recipe.description,
                "imageUrl": recipe.imageUrl ?? "",
                "difficulty": recipe.difficulty,
                "servings": recipe.servings
            ]
            
            let favoritesRef = db.collection("users").document(userId).collection("favorites").document(recipe.id)
            try await favoritesRef.setData(recipeData)
        } catch {
            print("Ошибка сохранения рецепта: \(error.localizedDescription)")
        }
    }
    
    private func removeFavoriteFromFirebase(_ recipe: Recipe) async {
         guard let userId = Auth.auth().currentUser?.uid else { return }

         do {
             try await db.collection("users").document(userId).collection("favorites").document(recipe.id).delete()
         } catch {
             print("Ошибка удаления рецепта: \(error.localizedDescription)")
         }
     }
}




