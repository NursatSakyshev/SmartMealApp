//
//  HomeViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

struct Recipe {
    let title: String
    let calories: Int
    let time: Int
    let imageName: String
}

class HomeViewController: UIViewController {
    
    //MARK: Test
    private let recipes: [Recipe] = [
        Recipe(title: "Салат с авокадо", calories: 320, time: 25, imageName: "salad"),
        Recipe(title: "Паста с лососем", calories: 450, time: 40, imageName: "pasta"),
        Recipe(title: "Греческий салат", calories: 290, time: 20, imageName: "greek"),
        Recipe(title: "Куриное филе", calories: 520, time: 35, imageName: "chicken")
    ]
    
    var collectionView: UICollectionView!
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 100),
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
    }
    
    func setupUI() {
        view.backgroundColor = .white
        [searchField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            searchField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        cell.imageView.backgroundColor = .blue
        return cell
    }
}
