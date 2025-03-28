//
//  DynamicTableView.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.03.2025.
//

import UIKit

class DynamicTableView: UITableView {
    private var heightConstraint: NSLayoutConstraint?

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            updateHeightConstraint()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    private func updateHeightConstraint() {
        if let existingConstraint = heightConstraint {
            existingConstraint.isActive = false // Удаляем старый constraint
            self.removeConstraint(existingConstraint)
        }
        
        let newConstraint = self.heightAnchor.constraint(equalToConstant: contentSize.height)
        newConstraint.isActive = true
        heightConstraint = newConstraint
    }
}
