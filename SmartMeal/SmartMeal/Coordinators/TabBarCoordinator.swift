//
//  TabBarCoordinator.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 01.03.2025.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let tabBar = TabBarController()
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home, image: Resources.Images.TabBar.home, tag: Tabs.home.rawValue)
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.search, image: Resources.Images.TabBar.search, tag: Tabs.search.rawValue)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        childCoordinators.append(searchCoordinator)
        searchCoordinator.start()
        
        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favorites, image: Resources.Images.TabBar.favorites, tag: Tabs.favorites.rawValue)
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)
        childCoordinators.append(favoritesCoordinator)
        favoritesCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.profile, image: Resources.Images.TabBar.profile, tag: Tabs.profile.rawValue)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
        
        tabBar.viewControllers = [
            homeNavigationController,
            searchNavigationController,
            favoritesNavigationController,
            profileNavigationController
        ]
        navigationController.viewControllers = [tabBar]
    }
    
    func removeChild(_ coordinator: Coordinator?) {
         guard let coordinator = coordinator else { return }
         childCoordinators.removeAll { $0 === coordinator }
     }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
