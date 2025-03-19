//
//  SearchViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 03.03.2025.
//

import Foundation
import UIKit

class SearchViewModel {
    var collectionCellViewModels: Dynamic<[CollectionCellViewModel]> = Dynamic([])
    var popularRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    var isLoading: ((Bool) -> Void)?
    
    func getCollectionCellViewModel(at indexPath: IndexPath) -> CollectionCellViewModel {
        return  self.collectionCellViewModels.value[indexPath.row]
     }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: .favoritesUpdated, object: nil)
    }
    
    //problem
//    private func updateCollectionViewModels() {
//        collectionCellViewModels.value = popularRecipes.map { CollectionCellViewModel(recipe: $0) }
//    }
//    
    private func updateCollectionViewModels(with recipes: [Recipe]) {
        collectionCellViewModels.value = recipes.map { CollectionCellViewModel(recipe: $0) }
    }
    
    @objc private func updateFavorites() {
        let currentRecipes = filteredRecipes.isEmpty ? popularRecipes : filteredRecipes
        updateCollectionViewModels(with: currentRecipes)
    }
    
    func callFuncToGetData() {
        Task {
            isLoading?(true)
            let recipes = await APIService.shared.getPopular()
            self.popularRecipes = recipes
            isLoading?(false)
            self.updateCollectionViewModels(with: popularRecipes)
        }
    }
}


//MARK: Search
extension SearchViewModel {
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
            filteredRecipes = popularRecipes.filter { $0.title.lowercased().contains(searchText) }
            updateCollectionViewModels(with: filteredRecipes)
        } else {
            filteredRecipes.removeAll()
            updateCollectionViewModels(with: popularRecipes)
        }
    }
}
