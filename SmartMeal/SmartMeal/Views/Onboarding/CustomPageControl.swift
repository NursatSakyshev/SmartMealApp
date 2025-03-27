//
//  CustomPageControl.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.03.2025.
//

import UIKit

class CustomPageControl: UIView {

    private var totalPages: Int = 0
    private var currentPage: Int = 0

    private let indicatorSize: CGFloat = 8
    private let lineWidth: CGFloat = 20
    private let spacing: CGFloat = 6

    func configure(totalPages: Int, currentPage: Int) {
        self.totalPages = totalPages
        self.currentPage = currentPage
        updateView()
    }

    func setCurrentPage(_ page: Int) {
        self.currentPage = page
        updateView()
    }

    private func updateView() {
        subviews.forEach { $0.removeFromSuperview() }

        var xOffset: CGFloat = 0

        for i in 0..<totalPages {
            let isActive = i == currentPage
            let width = isActive ? lineWidth : indicatorSize
            let frame = CGRect(x: xOffset, y: 0, width: width, height: indicatorSize)
            let indicator = UIView(frame: frame)
            indicator.backgroundColor = isActive ? UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1) : .lightGray
            indicator.layer.cornerRadius = indicatorSize / 2
            addSubview(indicator)

            xOffset += width + spacing
        }
        
        let totalWidth = xOffset - spacing
        let startX = (bounds.width - totalWidth) / 2
        subviews.forEach { $0.frame.origin.x += startX }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
}

