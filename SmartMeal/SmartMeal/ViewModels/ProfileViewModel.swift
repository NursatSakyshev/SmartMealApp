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
        guard let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "https://api.smartmeal.kz/v1/auth/me/") else {
            return
        }
        
        var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   if let error = error {
                       return
                   }
                   
                   do {
                       if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                           let userName = json["username"]
                           let jsonEmail = json["email"]
                           self.fullName.value = userName as? String ?? ""
                           self.email.value = jsonEmail as! String
                       } else {
                           print("error: profile")
                       }
                   } catch {
                       print("error: profile")
                   }
               }
           }
           
           task.resume()
    }
}

