//
//  RoundedView.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 11.03.2025.
//

import Foundation
import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 50
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] 
        self.clipsToBounds = true
    }
}
