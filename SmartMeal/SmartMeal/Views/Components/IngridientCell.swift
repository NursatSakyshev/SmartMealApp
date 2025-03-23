//
//  IngridientCell.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 26.02.2025.
//

import UIKit

class IngridientCell: UITableViewCell {
    
    static let identifier = "IngridientCell"
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        addSubview(nameLabel)
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(ingridient: Ingredient) {
        nameLabel.text = ingridient.name
        amountLabel.text = "\(ingridient.amount)"
    }
}
