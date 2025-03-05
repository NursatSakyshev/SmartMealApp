//
//  FavoritesManager.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 04.03.2025.
//

import UIKit

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}


class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoriteRecipes"
    var onFavoritesUpdated: (() -> Void)?
    private init() {}

    func isFavorite(_ recipe: Recipe) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.title == recipe.title }
    }

    func addToFavorites(_ recipe: Recipe) {
        var favorites = getFavorites()
        favorites.append(recipe)
        print("add \(recipe.title)")
        saveFavorites(favorites)
        onFavoritesUpdated?()
    }

    func removeFromFavorites(_ recipe: Recipe) {
        var favorites = getFavorites()
        favorites.removeAll { $0.title == recipe.title }
        print("remove \(recipe.title)")
        saveFavorites(favorites)
        onFavoritesUpdated?()
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
}

