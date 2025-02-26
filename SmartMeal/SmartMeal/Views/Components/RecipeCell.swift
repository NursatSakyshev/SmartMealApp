//
//  RecipeCell.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.text = "Hello world text"
        label.textColor = .black
        return label
    }()
    
    private var caloriesTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "320 ккал | 25 мин"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "some description some description some description some description some description"
        label.numberOfLines = 2
        return label
    }()
    
    lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detail", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.isHidden = false
        button.backgroundColor = UIColor(red: 66/255, green: 200/255, blue: 60/255, alpha: 1)
        return button
    }()
    
    override func prepareForReuse() {
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        [imageView, nameLabel, caloriesTimeLabel, descriptionLabel, detailButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        
        clipsToBounds = true
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            caloriesTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            caloriesTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            caloriesTimeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: caloriesTimeLabel.bottomAnchor, constant: 10),
            
            detailButton.heightAnchor.constraint(equalToConstant: 40),
            detailButton.widthAnchor.constraint(equalToConstant: 140),
            detailButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
        ])
    }
    
    func configure(recipe: Recipe) {
        nameLabel.text = recipe.title
        caloriesTimeLabel.text = "\(recipe.calories)ккал | \(recipe.time) мин"
        descriptionLabel.text = recipe.description
    }
}
