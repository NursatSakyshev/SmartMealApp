//
//  SearchViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 03.03.2025.
//

import Foundation

class SearchViewModel {
    var collectionCellViewModels: [CollectionCellViewModel] = []
    var popularRecipes: Dynamic<[Recipe]> = Dynamic([])
    var isLoading: ((Bool) -> Void)?
    
    func getCollectionCellViewModel(at indexPath: IndexPath) -> CollectionCellViewModel {
         return self.collectionCellViewModels[indexPath.row]
     }
    
    init() {
//        callFuncToGetData()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: .favoritesUpdated, object: nil)
    }
    
    private func updateCollectionViewModels() {
        collectionCellViewModels = popularRecipes.value.map { CollectionCellViewModel(recipe: $0) }
    }
    
    @objc private func updateFavorites() {
        updateCollectionViewModels()
    }
    
    func callFuncToGetData() {
        Task {
            isLoading?(true)
            let recipes = await APIService.shared.getPopular()
            self.popularRecipes.value = recipes
            isLoading?(false)
            self.updateCollectionViewModels()
        }
    }
}
