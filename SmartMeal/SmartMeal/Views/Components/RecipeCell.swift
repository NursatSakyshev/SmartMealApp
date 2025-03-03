//
//  RecipeCell.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    var viewModel: CollectionCellViewModel!

    static var identifier = "RecipeCell"
    
    let imageView = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.tintColor = .black
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func favoriteTapped() {
        viewModel.toggleFavorite()
    }
    
    private func updateFavoriteButton() {
        let image = UIImage(systemName: viewModel.isFavorite ? "bookmark.fill" : "bookmark")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        favoriteButton.setImage(image, for: .normal)
    }
    
    private var caloriesTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override func prepareForReuse() {
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
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            caloriesTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            caloriesTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            caloriesTimeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with viewModel: CollectionCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        caloriesTimeLabel.text = "\(viewModel.calories) ккал | \(viewModel.time) мин"
//        imageView.downloaded(from: viewModel.imageUrl)
        imageView.backgroundColor = .red
        updateFavoriteButton()
        
        viewModel.didUpdate = { [weak self] in
            self?.updateFavoriteButton()
        }
    }
}
