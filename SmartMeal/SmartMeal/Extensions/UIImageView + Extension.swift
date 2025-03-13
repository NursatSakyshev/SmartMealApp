//
//  UIImageView + Extension.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import UIKit

extension UIImageView {
    func downloaded(from url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request), let image = UIImage(data: cachedResponse.data) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            
            let cachedResponse = CachedURLResponse(response: httpURLResponse, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)
//            URLCache.shared.memoryCapacity = 50 * 1024 * 1024
//            URLCache.shared.diskCapacity = 200 * 1024 * 1024
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
