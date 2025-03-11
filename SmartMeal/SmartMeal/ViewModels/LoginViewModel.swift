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
    var isLoading: ((Bool) -> Void)?

    func login(email: String, password: String) {
        isLoading?(true)
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isLoading?(false)
            if let error = error {
                self.onError?(error.localizedDescription)
            } else {
                self.onSuccess?()
            }
        }
    }
}
