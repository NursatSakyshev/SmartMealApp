//
//  DividerView.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 25.02.2025.
//

import UIKit

class DividerView: UIView {

    private let leftLine = UIView()
    private let rightLine = UIView()
    private let label = UILabel()
    private let stackView = UIStackView()

    init(text: String = "Or", lineColor: UIColor = .gray) {
        super.init(frame: .zero)
        setupView(text: text, lineColor: lineColor)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(text: "Or", lineColor: .gray)
    }

    private func setupView(text: String, lineColor: UIColor) {
        leftLine.backgroundColor = lineColor
        rightLine.backgroundColor = lineColor

        leftLine.translatesAutoresizingMaskIntoConstraints = false
        rightLine.translatesAutoresizingMaskIntoConstraints = false

        label.text = text
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(leftLine)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rightLine)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            leftLine.heightAnchor.constraint(equalToConstant: 1),
            leftLine.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),

            rightLine.heightAnchor.constraint(equalToConstant: 1),
            rightLine.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4)
        ])
    }
}

