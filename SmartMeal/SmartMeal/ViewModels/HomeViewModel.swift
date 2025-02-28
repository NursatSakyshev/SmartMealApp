//
//  HomeViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import Foundation

class HomeViewModel {
    var tableViewCellModels: [TableViewCellModel] = []
    let categories = ["Recommendations", "Popular", "Quick & Easy", "Healthy Choices"]
    
    private var apiService = APIService()
    
    var bind : (() -> Void) = {}
   
    func getTableCellModel(at indexPath: IndexPath) -> TableViewCellModel {
         return self.tableViewCellModels[indexPath.section]
     }
    
    init() {
        callFuncToGetData()
    }
    
    func callFuncToGetData() {
        let group = DispatchGroup() 
        
        group.enter()
        APIService.shared.getRecommendations {
            self.tableViewCellModels.append(TableViewCellModel(recipes: $0))
            group.leave()
        }
        
        group.enter()
        APIService.shared.getPopular {
            self.tableViewCellModels.append(TableViewCellModel(recipes: $0))
            group.leave()
        }
        
        group.enter()
        APIService.shared.getQuickEasy {
            self.tableViewCellModels.append(TableViewCellModel(recipes: $0))
            group.leave()
        }
        
        group.enter()
        APIService.shared.getHealthy {
            self.tableViewCellModels.append(TableViewCellModel(recipes: $0))
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.bind()
        }
    }
}




