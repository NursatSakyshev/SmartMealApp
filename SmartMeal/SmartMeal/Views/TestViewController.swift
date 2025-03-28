//
//  TestViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 21.03.2025.
//

import UIKit

class TestViewController: UIViewController {
    var stepTableView: UITableView!
    
    func setupSteps() {
        
        stepTableView = UITableView()
        stepTableView.dataSource = self
        stepTableView.delegate = self
//        stepTableView.estimatedRowHeight = 100  // Оценочный размер (не влияет на реальный размер)
//        stepTableView.rowHeight = UITableView.automaticDimension  // Автоматический расчет высоты
        stepTableView.tag = 2
        stepTableView.isUserInteractionEnabled = true
        stepTableView.register(StepCell.self, forCellReuseIdentifier: StepCell.identifier)
        
        view.addSubview(stepTableView)
        stepTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        stepTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stepTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stepTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stepTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stepTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        setupSteps()
    }
}



extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StepCell.identifier, for: indexPath) as? StepCell else { return UITableViewCell() }
        let step = Step(text: "step1", imageURL: "asdf", stepNumber: "step1/2")
        cell.configure(step: step)
        return cell
    }
    
    
}




/**
 
 Healthy food is food that gives you all the nutrients you need to stay healthy, feel well and have plenty of energy
 
 */
