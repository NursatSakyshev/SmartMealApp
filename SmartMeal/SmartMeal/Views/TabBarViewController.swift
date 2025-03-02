//
//  TabBarViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import UIKit

enum Tabs: Int {
    case home
    case search
    case favorites
    case profile
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inActive
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }
}

/*
 final class TabBarController: UITabBarController {
     var childCoordinators = [Coordinator]()
     
     override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
         super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
         configure()
         setup()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func setup() {
 //        self.navigationController.delegate = self
         
         let homeNavigationController = UINavigationController()
         homeNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home, image: Resources.Images.TabBar.home, tag: Tabs.home.rawValue)
         let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
         childCoordinators.append(homeCoordinator)
         homeCoordinator.start()
         
         let searchNavigationController = UINavigationController()
 //        searchNavigationController.delegate = self
         searchNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.search, image: Resources.Images.TabBar.search, tag: Tabs.search.rawValue)
         let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
         childCoordinators.append(searchCoordinator)
         searchCoordinator.start()
         
         let favoritesNavigationController = UINavigationController()
 //        favoritesNavigationController.delegate = self
         favoritesNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favorites, image: Resources.Images.TabBar.favorites, tag: Tabs.favorites.rawValue)
         let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)
         childCoordinators.append(favoritesCoordinator)
         favoritesCoordinator.start()
         
         let profileNavigationController = UINavigationController()
 //        profileNavigationController.delegate = self
         profileNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.profile, image: Resources.Images.TabBar.profile, tag: Tabs.profile.rawValue)
         let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
         childCoordinators.append(profileCoordinator)
         profileCoordinator.start()
         
         viewControllers = [
                homeNavigationController,
                searchNavigationController,
            ]
     }
     
     private func configure() {
         tabBar.tintColor = Resources.Colors.active
         tabBar.barTintColor = Resources.Colors.inActive
         tabBar.layer.borderColor = Resources.Colors.separator.cgColor
         tabBar.layer.borderWidth = 1
         tabBar.layer.masksToBounds = true
     }
 }

 
 
 */
