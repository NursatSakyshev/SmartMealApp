//
//  Resources.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.02.2025.
//

import UIKit

enum Resources {
    enum Colors {
        static var active = UIColor.black
        static var inActive = UIColor.white
        static var separator = UIColor.gray
    }
    
    enum Strings {
        enum TabBar {
            static var home = "Home"
            static var favorites = "Favorites"
            static var search = "Search"
            static var profile = "Profile"
        }
    }
    
    enum Images {
        enum TabBar {
            static var home = UIImage(systemName: "house.fill")
            static var search = UIImage(systemName: "magnifyingglass.circle.fill")
            static var favorites = UIImage(systemName: "heart.fill")
            static var profile = UIImage(systemName: "person.circle.fill")
        }
    }
}
