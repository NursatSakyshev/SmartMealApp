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
//        callFuncToGetData()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: .favoritesUpdated, object: nil)
    }
    
    //problem
    private func updateCollectionViewModels() {
        collectionCellViewModels.value = popularRecipes.map { CollectionCellViewModel(recipe: $0) }
    }
    
    private func updateFilteredCollectionViewModels() {
        collectionCellViewModels.value = filteredRecipes.map({ CollectionCellViewModel(recipe: $0) })
    }
    
    @objc private func updateFavorites() {
        updateCollectionViewModels()
    }
    
    func callFuncToGetData() {
        Task {
            isLoading?(true)
            let recipes = await APIService.shared.getPopular()
            self.popularRecipes = recipes
            isLoading?(false)
            self.updateCollectionViewModels()
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
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {
                updateCollectionViewModels()
                return
            }
            
            filteredRecipes = popularRecipes.filter({
                $0.title.lowercased().contains(searchText)
            })
        }
        updateFilteredCollectionViewModels()
    }
}
