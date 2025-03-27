//
//  OnboardingPageViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 27.03.2025.
//

import UIKit
import SnapKit

class OnboardingPageViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Smart Meal"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .brown
        label.textAlignment = .center
        return label
    }()
    
    var imageName: String
    var titleText: String
    var descriptionText: String
    var imageHeight: CGFloat
    var imageWidth: CGFloat
    var isFirstPage: Bool
    
    init(imageName: String, title: String, description: String, imageHeight: CGFloat, imageWidth: CGFloat, isFirstPage: Bool = false) {
        self.imageName = imageName
        self.titleText = title
        self.descriptionText = description
        self.imageHeight = imageHeight
        self.imageWidth = imageWidth
        self.isFirstPage = isFirstPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(imageHeight)
            make.width.equalTo(imageWidth)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(75)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-75)
            make.centerX.equalToSuperview()
        }

        if isFirstPage {
            view.addSubview(appNameLabel)
            appNameLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(6)
                make.centerX.equalToSuperview()
            }
        }
        descriptionLabel.snp.makeConstraints { make in
            if isFirstPage {
                make.top.equalTo(appNameLabel.snp.bottom).offset(14)
            } else {
                make.top.equalTo(titleLabel.snp.bottom).offset(14)
            }
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
    }
}
