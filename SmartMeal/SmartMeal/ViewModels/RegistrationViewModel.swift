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
    var onError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    func register(fullname: String, email: String, password: String) {
        isLoading?(true)
        
        guard let url = URL(string: "https://api.smartmeal.kz/v1/auth/register/") else {
            isLoading?(false)
            onError?("wrong url")
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
            onError?("error3")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading?(false)
                if let error = error {
//                    print("Error: \(error.localizedDescription)")
                    self.onError?(error.localizedDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    let tokens = json?["tokens"] as? [String: Any]
                    if let access = tokens?["access"] as? String,
                       let refresh = tokens?["refresh"] as? String
                    {
                        APIService.shared.saveToken(access: access, refresh: refresh)
                        self.onSuccess?()
                    } else {
                        self.onError?("user with this name already exists")
                    }
                } catch {
                    self.onError?("error2")
                }
                
                
                print("registration: \(data!), response: \(response!)")
            }
        }
        task.resume()
    }
}
