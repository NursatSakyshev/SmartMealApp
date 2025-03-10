//
//  LoginViewModel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 10.03.2025.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.onError?(error.localizedDescription)
            } else {
                self.onSuccess?()
            }
        }
    }
}
