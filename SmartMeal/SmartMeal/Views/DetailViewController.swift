//
//  DetailViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel!
    
    //MARK: Test
   
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var tableView: UITableView!
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
        return label
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
    }
    
    func updateUI() {
        nameLabel.text = viewModel.recipe.title
        recipeDescription.text = viewModel.recipe.description
        imageView.downloaded(from: viewModel.recipe.imageUrl!)
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        [imageView, nameLabel, stackView, descriptionLabel, recipeDescription, ingredientsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = false
        tableView.register(IngridientCell.self, forCellReuseIdentifier: IngridientCell.identifier)
        
        contentView.addSubview(tableView)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.ingridients.count * 50)),
        ])
    }
    
    private var timeLabel: TextWithIcon = {
        let timeLabel = TextWithIcon(text: "1 час 30 мин", with: ImageAssets.clock)
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
        updateUI()
        configureScrollView()
        configureContentView()
        prepareScrollView()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        view.backgroundColor = .white

        [timeLabel, difficultyLabel, portionsLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 240),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
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


//MARK: Extension
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.ingridients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngridientCell.identifier, for: indexPath) as? IngridientCell else {
            return UITableViewCell()
        }
        cell.configure(ingridient: viewModel.ingridients[indexPath.row])
        return cell
    }
}
