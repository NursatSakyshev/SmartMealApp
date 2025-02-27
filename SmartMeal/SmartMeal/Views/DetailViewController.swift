//
//  DetailViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: Test
    var ingridients = [
        Ingridient(name: "Свекла", amount: 500, unit: "кг"),
        Ingridient(name: "Капуста", amount: 230, unit: "г"),
        Ingridient(name: "Морковь", amount: 150, unit: "кг"),
        Ingridient(name: "Кортофель", amount: 200, unit: "кг"),
        Ingridient(name: "Лук", amount: 100, unit: "кг"),
        Ingridient(name: "Томатная паста", amount: 50, unit: "мл"),
    ]
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    var tableView: UITableView!
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Классический борщ"
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Описание"
        return label
    }()
    
    private var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Ингридиенты"
        return label
    }()
    
    private var recipeDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "Борщ - это традиционный славянский суп, известный своим насыщенным вкусом и ярким цветом. Это блюдо не только вкусное, но и питательное, идеально подходящее для холодных дней."
        return label
    }()
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = false
        tableView.register(IngridientCell.self, forCellReuseIdentifier: IngridientCell.identifier)
        
        view.addSubview(tableView)
        tableView.backgroundColor = .green
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private var timeLabel: TextWithIcon = {
        let timeLabel = TextWithIcon(text: "1 час 30 мин", with: ImageAssets.users)
        return timeLabel
    }()
    
    private var difficultyLabel: TextWithIcon = {
        let timeLabel = TextWithIcon(text: "Средняя сложность", with: ImageAssets.difficulty)
        return timeLabel
    }()
    
    private var portionsLabel: TextWithIcon = {
        let timeLabel = TextWithIcon(text: "4 порции", with: ImageAssets.users)
        return timeLabel
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        [imageView, nameLabel, stackView, descriptionLabel, recipeDescription, ingredientsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [timeLabel, difficultyLabel, portionsLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 240),
            
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 70),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            recipeDescription.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            recipeDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            recipeDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            ingredientsLabel.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: 20),
            ingredientsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
    }
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingridients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngridientCell.identifier, for: indexPath) as? IngridientCell else {
            return UITableViewCell()
        }
        cell.configure(ingridient: ingridients[indexPath.row])
        return cell
    }
}
