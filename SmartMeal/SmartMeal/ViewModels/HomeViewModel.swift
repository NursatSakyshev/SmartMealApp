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
        self.apiService.getData { (recipies) in
            recipies.forEach {
                self.tableViewCellModels.append(TableViewCellModel(recipes: $0))
            }
            
            self.bind()
        }
    }
}












///    var recipesByCategory: [[Recipe]] = [] {
//         didSet {
//             self.bind()
//         }
//     }





//    func fetchRecipes(completion: @escaping () -> Void) {
//        // Здесь загружаешь рецепты из API или базы данных
//        self.recipes = Recipe.recipes
//        completion()
//    }
