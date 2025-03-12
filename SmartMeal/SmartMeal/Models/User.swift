//
//  User.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 12.03.2025.
//

import Foundation

struct User {
    let uid: String
    let fullname: String
    let email: String
    
    var dictionary: [String: Any] {
        return ["id": UUID(), "fullname": fullname, "email": email]
    }
}
