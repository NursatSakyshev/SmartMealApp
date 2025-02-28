//
//  RecipeCategoryCel.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 28.02.2025.
//

import UIKit

class RecipeCategoryCell: UITableViewCell {
    
    var collectionView: UICollectionView!
    private var recipesViewModels: [CollectionViewCellModel] = []
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 300)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TableViewCellModel) {
        self.recipesViewModels = viewModel.collecionViewCellModels
        collectionView.reloadData()
    }

}

extension RecipeCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesViewModels.count
    }
    
    override func prepareForReuse() {
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: recipesViewModels[indexPath.row])
        return cell
    }
}

