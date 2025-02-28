//
//  ApiService.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import Foundation
import UIKit

class APIService {
    static let shared = APIService()
    func getRecommendations(completion: @escaping ([Recipe]) -> Void) {
        completion(Array(Recipe.recipes.prefix(2)))
    }
    
    private let imageCache = NSCache<NSString, NSData>()
    
    func getPopular(completion: @escaping ([Recipe]) -> Void) {
        completion(Array(Recipe.recipes.shuffled().prefix(3)))
    }
    
    func getQuickEasy(completion: @escaping ([Recipe]) -> Void) {
        completion(Array(Recipe.recipes.suffix(3)))
    }
    
    func getHealthy(completion: @escaping ([Recipe]) -> Void) {
        completion(Recipe.recipes)
    }
    
    func fetchImageData(from url: String, completion: @escaping (Data?) -> Void) {
        let key = url as NSString
        
        if let cachedData = imageCache.object(forKey: key) {
            print("cash")
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
}

