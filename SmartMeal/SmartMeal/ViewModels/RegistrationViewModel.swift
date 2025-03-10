//
//  RegistrationViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 10.03.2025.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel {
    var onSuccess: (() -> Void)?
    var onError: (() -> Void)?
    
    func register(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.onError?()
            } else {
                self.onSuccess?()
            }
        }
    }
}
