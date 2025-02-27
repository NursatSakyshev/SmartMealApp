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
    func updateBadgeValue(value: String?, color: UIColor?) {
        tabBar.items![1].badgeValue = value
        tabBar.items![1].badgeColor = color
    }
    
    
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
        let homeViewController = HomeViewController()
        let profileViewController = ProfileViewController()
        let savedViewController = FavoritesViewController()
        let searchViewController = SearchViewController()
        
        let navVC1 = UINavigationController(rootViewController: homeViewController)
        let navVC2 = UINavigationController(rootViewController: searchViewController)
        let navVC3 = UINavigationController(rootViewController: savedViewController)
        let navVC4 = UINavigationController(rootViewController: profileViewController)
        
        
        
        navVC1.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home, image: Resources.Images.TabBar.home, tag: Tabs.home.rawValue)
        navVC2.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.search, image: Resources.Images.TabBar.search, tag: Tabs.search.rawValue)
        navVC3.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.favorites, image: Resources.Images.TabBar.favorites, tag: Tabs.favorites.rawValue)
        navVC4.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.profile, image: Resources.Images.TabBar.profile, tag: Tabs.profile.rawValue)
        
        setViewControllers([
            navVC1,
            navVC2,
            navVC3,
            navVC4,
        ], animated: true)
    }
}
