//
//  stepsCell.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.03.2025.
//

import Foundation
import UIKit

class StepCell: UITableViewCell {
    
    var stepTextLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        return textLabel
    }()
    
    var stepImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    var numberLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    static let identifier = "StepCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        [stepTextLabel, stepImageView, numberLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.backgroundColor = .green
        
        NSLayoutConstraint.activate([
            stepTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stepTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stepTextLabel.topAnchor.constraint(equalTo: topAnchor),
            
            stepImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stepImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stepImageView.topAnchor.constraint(equalTo: stepTextLabel.bottomAnchor, constant: 10),
            stepImageView.heightAnchor.constraint(equalToConstant: 220),
            
            numberLabel.topAnchor.constraint(equalTo: stepImageView.bottomAnchor, constant: 10),
            numberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(step: Step) {
        stepTextLabel.text = step.text
        numberLabel.text = step.stepNumber
        stepImageView.backgroundColor = .red
    }
}
