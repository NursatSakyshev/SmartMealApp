//
//  HomeViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class HomeViewModel {
    var tableViewCellModels: [TableCellViewModel] = []
    var categories: [String]?
    var isLoading: ((Bool) -> Void)?
    
    var bind : (() -> Void) = {}
    
    func getTableCellModel(at indexPath: IndexPath) -> TableCellViewModel {
        guard indexPath.section < tableViewCellModels.count else { return TableCellViewModel(recipes: []) }
        return tableViewCellModels[indexPath.section]
    }
    
    init() {
        //        self.callFuncToGetData()
    }
    
    func callFuncToGetData() {
        let group = DispatchGroup()
        
        isLoading?(true)
        group.enter()
        
        APIService.shared.getPopular { recipes in
            print("1: \(recipes.count)")
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        
        group.enter()
        APIService.shared.getRecommendations { recipes in
            print("2: \(recipes.count)")
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        group.enter()
        
        APIService.shared.getQuickEasy { recipes in
            print("3: \(recipes.count)")
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        
        group.enter()
        
        APIService.shared.getHealthy { recipes in
            print("4: \(recipes.count)")
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        
        group.notify(queue: .main) {
            self.categories = ["Recommendations", "Popular", "Quick & Easy", "Healthy Choices"]
            self.isLoading?(false)
            self.bind()
        }
    }
}




