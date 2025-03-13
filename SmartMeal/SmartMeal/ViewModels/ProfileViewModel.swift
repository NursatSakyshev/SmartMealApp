//
//  ProfileViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 11.03.2025.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {
    
    var fullName: Dynamic<String> = Dynamic("")
    var email: Dynamic<String> = Dynamic("")
    
    func fetchUserData() {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            
            APIService.shared.fetchUser(uid: uid) { [weak self] user in
                if let user = user {
                    self?.fullName.value = user.fullname
                    self?.email.value = user.email
                } else {
                    print("Ошибка: пользователь не найден")
                }
            }
        } else {
            print("Пользователь не авторизован")
        }
    }
}

