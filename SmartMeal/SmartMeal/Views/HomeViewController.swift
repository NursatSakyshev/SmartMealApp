//
//  HomeViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

class HomeViewController: UIViewController {
    private var viewModel = HomeViewModel()
    
    private let recommendationLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommendations"
        label.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var collectionView: UICollectionView!
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 20),

            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
            
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        viewModel.fetchRecipes {
            self.collectionView.reloadData()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        [recommendationLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            recommendationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recommendationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recommendationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        cell.imageView.backgroundColor = .blue
        cell.configure(recipe: viewModel.recipes[indexPath.row], imageName: "dishimage1")
        return cell
    }
}
