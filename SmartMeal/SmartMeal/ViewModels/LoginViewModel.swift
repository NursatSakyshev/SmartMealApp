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
    
    func login(userName: String, password: String) {
        isLoading?(true)
        
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/login/") else {
            isLoading?(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "username": userName,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            isLoading?(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading?(false)
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    self.onError?(error.localizedDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    if let access = json?["access"] as? String,
                       let refresh = json?["refresh"] as? String
                    {
                        APIService.shared.saveToken(access: access, refresh: refresh)
                        self.onSuccess?()
                    } else {
                        self.onError?("error 1")
                    }
                } catch {
                    self.onError?("error 2")
                }
            }
        }
        task.resume()
    }
}
