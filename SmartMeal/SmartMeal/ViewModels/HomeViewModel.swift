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
    let categories = ["Recommendations", "Popular", "Quick & Easy", "Healthy Choices"]
    
    var bind : (() -> Void) = {}
   
    func getTableCellModel(at indexPath: IndexPath) -> TableCellViewModel {
        guard indexPath.section < tableViewCellModels.count else { return TableCellViewModel(recipes: []) }
          return tableViewCellModels[indexPath.section]
     }
    
    init() {
        self.callFuncToGetData()
    }
    
    func callFuncToGetData() {
        let group = DispatchGroup() 
        
        group.enter()
        
        Task {
            let recipes = await APIService.shared.getRecommendations()
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        group.enter()
        Task {
            let recipes = await APIService.shared.getPopular()
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        group.enter()
        Task {
            let recipes = await APIService.shared.getQuickEasy()
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        group.enter()
        Task {
            let recipes = await APIService.shared.getHealthy()
            self.tableViewCellModels.append(TableCellViewModel(recipes: recipes))
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.bind()
        }
    }
}




