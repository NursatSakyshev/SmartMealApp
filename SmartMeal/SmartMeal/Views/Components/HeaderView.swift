//
//  HeaderView.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 12.03.2025.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    static var identifier = "headerView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "For You"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
