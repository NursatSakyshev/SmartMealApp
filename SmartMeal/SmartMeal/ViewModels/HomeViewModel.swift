//
//  HomeViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import Foundation

class HomeViewModel {
    var tableViewCellModels: [TableCellViewModel] = []
    let categories = ["Recommendations", "Popular", "Quick & Easy", "Healthy Choices"]
    
    var bind : (() -> Void) = {}
   
    func getTableCellModel(at indexPath: IndexPath) -> TableCellViewModel {
        return self.tableViewCellModels[indexPath.section]
     }
    
    init() {
        self.callFuncToGetData()
    }
    
    func callFuncToGetData() {
        let group = DispatchGroup() 
        
        group.enter()
        APIService.shared.getRecommendations {
            self.tableViewCellModels.append(TableCellViewModel(recipes: $0))
            group.leave()
        }
        
        group.enter()
        APIService.shared.getPopular {
            self.tableViewCellModels.append(TableCellViewModel(recipes: $0))
            group.leave()
        }
        
        group.enter()
        APIService.shared.getQuickEasy {
            self.tableViewCellModels.append(TableCellViewModel(recipes: $0))
            group.leave()
        }
        
        group.enter()
        APIService.shared.getHealthy {
            self.tableViewCellModels.append(TableCellViewModel(recipes: $0))
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.bind()
        }
    }
}




