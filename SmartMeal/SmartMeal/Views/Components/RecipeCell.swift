//
//  RecipeCell.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class RecipeCell: UICollectionViewCell {

    static var identifier = "RecipeCell"
    
    let imageView = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    //MARK: favorite button
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return button
    }()
    
    var isFavorite = false
    
    @objc func favoriteTapped() {
        isFavorite.toggle()
        
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private var caloriesTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
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
        [imageView, nameLabel, caloriesTimeLabel, favoriteButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        clipsToBounds = true
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
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
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(with viewModel: CollectionViewCellModel) {
        nameLabel.text = viewModel.name
        caloriesTimeLabel.text = "\(viewModel.calories) ккал | \(viewModel.time) мин"
        imageView.downloaded(from: viewModel.imageUrl)
    }
}
