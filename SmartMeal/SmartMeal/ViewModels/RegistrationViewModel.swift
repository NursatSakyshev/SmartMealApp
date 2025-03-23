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
        
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/register/") else {
            isLoading?(false)
            onError?()
            return
        }
        
        var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "username": fullname,
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            isLoading?(false)
            onError?()
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
             DispatchQueue.main.async {
                 self.isLoading?(false)
                 if let error = error {
                     print("Error: \(error.localizedDescription)")
                     self.onError?()
                     return
                 }
                 
                 print("registration: \(data), response: \(response)")
//                 self.onSuccess?()
             }
         }
         task.resume()
    }
}
