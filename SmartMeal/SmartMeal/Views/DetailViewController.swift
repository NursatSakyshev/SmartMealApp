//
//  DetailViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel!
    //MARK: Sticky header properties
    var contentViewTopAnchor: NSLayoutConstraint!
    var headerViewHeightAnchor: NSLayoutConstraint!
    
    var stepsImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var tableView: UITableView!
    
    var stepTableView: UITableView!
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
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
    
    private var stepsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Шаги"
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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
    }
    
    func updateUI() {
        nameLabel.text = viewModel.recipe.title
        recipeDescription.text = viewModel.recipe.description
        imageView.sd_setImage(with: URL(string: viewModel.recipe.imageUrl!))
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        [imageView, nameLabel, stackView, descriptionLabel, recipeDescription, ingredientsLabel, stepsImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentViewTopAnchor,
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
        tableView.tag = 1
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
    
    private var timeLabel: TextWithIcon!
    
    private var difficultyLabel: TextWithIcon!
    
    private var servingsLabel: TextWithIcon!
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        updateUI()
        configureScrollView()
        configureContentView()
        prepareScrollView()
        setupUI()
        setupTableView()
//        setupSteps()
    }
    
    func setupSteps() {
        contentView.addSubview(stepsLabel)
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stepTableView = UITableView()
        stepTableView.dataSource = self
        stepTableView.delegate = self
        stepTableView.tag = 2
        stepTableView.isUserInteractionEnabled = false
        stepTableView.register(StepCell.self, forCellReuseIdentifier: StepCell.identifier)
        
        contentView.addSubview(stepTableView)
        stepTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        stepTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stepsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            stepsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            stepTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stepTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stepTableView.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor, constant: 20),
            stepTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stepTableView.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.steps.count * 600)),
        ])
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        scrollView.contentInsetAdjustmentBehavior = .never
        
        timeLabel = TextWithIcon(text: "\(viewModel.time)", with: ImageAssets.time)
        difficultyLabel = TextWithIcon(text: "\(viewModel.dishType)", with: ImageAssets.dishType)
        servingsLabel = TextWithIcon(text: "\(viewModel.cuisine)", with: ImageAssets.cuisine)

        [timeLabel, difficultyLabel, servingsLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        headerViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerViewHeightAnchor,
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
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
        tableView.tag == 1 ? viewModel.ingridients.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngridientCell.identifier, for: indexPath) as? IngridientCell else {
                return UITableViewCell()
            }
            cell.configure(ingridient: viewModel.ingridients[indexPath.row])
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepCell.identifier, for: indexPath) as? StepCell else {
                return UITableViewCell()
            }
            cell.configure(step: viewModel.steps[0])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag != 1 {
            return 400
        }
        return 50
    }
}


//MARK: UIscrollView + extension
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetheight = scrollView.contentOffset.y
        if contentOffsetheight < 0 {
            //change the anchors
            contentViewTopAnchor.constant = contentOffsetheight
            headerViewHeightAnchor.constant = 300 + (-contentOffsetheight)
        }
    }
}
