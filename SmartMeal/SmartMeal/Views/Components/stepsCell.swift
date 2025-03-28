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
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    var stepImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var numberLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "StepCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        [stepTextLabel, stepImageView, numberLabel].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // stepTextLabel constraints
            stepTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stepTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stepTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            // stepImageView constraints
            stepImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stepImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stepImageView.topAnchor.constraint(equalTo: stepTextLabel.bottomAnchor, constant: 10),
            stepImageView.heightAnchor.constraint(equalToConstant: 220),
            
            // numberLabel constraints
            numberLabel.topAnchor.constraint(equalTo: stepImageView.bottomAnchor, constant: 10),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(step: Step) {
        stepTextLabel.text = step.text
        numberLabel.text = step.stepNumber
        stepImageView.sd_setImage(with: URL(string: step.imageURL))
        stepImageView.backgroundColor = .gray
    }
}
