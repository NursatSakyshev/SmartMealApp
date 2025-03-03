//
//  SearchViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 03.03.2025.
//

import Foundation

class SearchViewModel {
    var collectionCellViewModels: [CollectionCellViewModel] = []
    var popularRecipes: [Recipe]!
    
    func getCollectionCellViewModel(at indexPath: IndexPath) -> CollectionCellViewModel {
         return self.collectionCellViewModels[indexPath.row]
     }
    
    init() {
        callFuncToGetData()
        popularRecipes.forEach {
            collectionCellViewModels.append(CollectionCellViewModel(recipe: $0))
        }
    }
    
    func callFuncToGetData() {
        APIService.shared.getQuickEasy {
            self.popularRecipes = $0
        }
    }
}
