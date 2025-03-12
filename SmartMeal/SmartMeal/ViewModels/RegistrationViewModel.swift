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
    var isLoading: ((Bool) -> Void)?
    
    func register(fullname: String, email: String, password: String) {
        isLoading?(true)
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.isLoading?(false)
            let uid = result?.user.uid
            APIService.shared.saveUserToFirestore(uid: uid ?? "", fullname: fullname, email: email)
            if error != nil {
                self.onError?()
            } else {
                self.onSuccess?()
            }
        }
    }
}
