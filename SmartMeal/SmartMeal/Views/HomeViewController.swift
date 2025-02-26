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
        collectionView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 40),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
        ])
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 310)
        layout.minimumLineSpacing = 60
        return layout
    }
    
    lazy var searchField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = "Enter products"
        return textField
    }()
    
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
        [searchField, recommendationLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            recommendationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            recommendationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            recommendationLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 60),
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
        cell.configure(recipe: viewModel.recipes[indexPath.row])
        return cell
    }
}
