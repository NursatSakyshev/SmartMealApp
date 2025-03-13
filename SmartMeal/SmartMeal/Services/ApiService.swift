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
    
    func getRecommendations() async -> [Recipe] {
        let recipes = await getRecipes(collection: db.collection("recipes"))
        return Array(recipes.prefix(3))
    }
    
    func getPopular() async -> [Recipe] {
        let recipes = await getRecipes(collection: db.collection("recipes"))
        return recipes
    }
    
    
    func getQuickEasy() async -> [Recipe] {
        let recipes = await getRecipes(collection: db.collection("recipes"))
        return Array(recipes.dropFirst(6).prefix(3))
    }
    
    func getHealthy() async -> [Recipe] {
        let recipes = await getRecipes(collection: db.collection("recipes"))
        return Array(recipes.suffix(3))
    }
    
    func fetchUser(uid: String, completion: @escaping (User?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                print("Ошибка при получении данных: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let fullname = data?["fullname"] as? String ?? ""
                let email = data?["email"] as? String ?? ""
                let user = User(uid: uid, fullname: fullname, email: email)
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    func saveUserToFirestore(uid: String, fullname: String, email: String) {
        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
            "fullname": fullname,
            "email": email
        ]
        
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                print("user data saved")
            }
        }
    }
    
    func saveRecipeImageUrl(recipeId: String, imageUrl: String) {
        let db = Firestore.firestore()
        db.collection("recipes").document(recipeId).updateData(["imageUrl": imageUrl]) { error in
            if let error = error {
                print("Error URL: \(error.localizedDescription)")
            } else {
                print("URL saved")
            }
        }
    }
    
    
    func addRecipe(reference: DocumentReference, recipe: Recipe) {
//        let recipeRef = db.collection("recipes").document() // создаем пустой документ и получаем его ID
//        let recipeId = recipeRef.documentID // Firestore сам генерирует ID
        
        let recipeData: [String: Any] = [
            "id": recipe.id, // добавляем ID в документ
            "title": recipe.title,
            "calories": recipe.calories,
            "time": recipe.time,
            "description": recipe.description,
            "imageUrl": recipe.imageUrl ?? "",
            "difficulty": recipe.difficulty,
            "servings": recipe.servings
        ]
        
        reference.setData(recipeData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(recipe.id)")
                
                
                for ingredient in recipe.ingridients {
                    reference.collection("ingredients").addDocument(data: [
                        "name": ingredient.name,
                        "amount": ingredient.amount,
                        "unit": ingredient.unit
                    ])
                }
            }
        }
        
    }
    
    func saveFavoriteRecipe(userId: String, recipe: Recipe) {
        let db = Firestore.firestore()
        let favoritesRef = db.collection("users").document(userId).collection("favorites").document(recipe.id)
        
        addRecipe(reference: favoritesRef, recipe: recipe)
    }
    
    func getFavoriteRecipes(userId: String) async -> [Recipe] {
        let favoritesRef = db.collection("users").document(userId).collection("favorites")
        return await getRecipes(collection: favoritesRef)
    }
    
    func getRecipes(collection: CollectionReference) async -> [Recipe] {
        do {

            let snapshot = try await collection.getDocuments()
            var loadedRecipes: [Recipe] = []


            for document in snapshot.documents {
                let data = document.data()
                
                let id = document.documentID
                let title = data["title"] as? String ?? ""
                let calories = data["calories"] as? Int ?? 0
                let time = data["time"] as? Int ?? 0
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String
                let difficulty = data["difficulty"] as? String ?? ""
                let servings = data["servings"] as? Int ?? 0
                

                let ingredients = try await getIngredientsForRecipe(recipeId: id, collecion: collection)
                

                let recipe = Recipe(id: id, title: title, calories: calories, time: time, description: description, imageUrl: imageUrl, ingridients: ingredients, difficulty: difficulty, servings: servings)
                loadedRecipes.append(recipe)
            }
            
            return loadedRecipes
            
        } catch {
            print("\(error.localizedDescription)")
            return []
        }
    }
    
    func getIngredientsForRecipe(recipeId: String, collecion: CollectionReference) async throws -> [Ingridient] {
        let snapshot = try await collecion.document(recipeId).collection("ingredients").getDocuments()
        
        var ingredients: [Ingridient] = []
        
        for ingredientDoc in snapshot.documents {
            let ingredientData = ingredientDoc.data()
            let name = ingredientData["name"] as? String ?? ""
            let amount = ingredientData["amount"] as? Int ?? 0
            let unit = ingredientData["unit"] as? String ?? ""
            let ingredient = Ingridient(name: name, amount: amount, unit: unit)
            ingredients.append(ingredient)
        }
        
        return ingredients
    }
}





//    func uploadImage(image: UIImage, recipeId: String, completion: @escaping (String?) -> Void) {
//        let storageRef = Storage.storage().reference().child("recipe_images/\(recipeId).jpg")
//
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//            completion(nil)
//            return
//        }
//
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//
//        storageRef.putData(imageData, metadata: metadata) { (_, error) in
//            if let error = error {
//                print("Ошибка загрузки изображения: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            // Получаем URL изображения
//            storageRef.downloadURL { (url, error) in
//                APIService.shared.saveRecipeImageUrl(recipeId: recipeId, imageUrl: url!.absoluteString)
//                completion(url?.absoluteString)
//            }
//        }
//    }



//
//                let image = UIImage(named: "dishImage\(index + 1)")
////                print("index \(index + 1)")
////                    guard let image = image else { print("image error at: \(index)"); return }
//                if image == nil {
//                    print("image error at: \(index + 1)"); return
//                }
//                uploadImage(image: image!, recipeId: id) { url in
//                    print("url saved:\(index + 1)")
////                    imageUrl = url
//                }
