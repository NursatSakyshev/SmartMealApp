//
//  CustomButton.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        tintColor = .white
        backgroundColor = UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1)
        layer.cornerRadius = 30
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
}

