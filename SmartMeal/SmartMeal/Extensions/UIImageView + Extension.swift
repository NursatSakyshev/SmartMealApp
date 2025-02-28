//
//  UIImageView + Extension.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        print("load image")
        APIService.shared.fetchImageData(from: url) { data in
            if let data = data, let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
    
    func downloaded(from url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
