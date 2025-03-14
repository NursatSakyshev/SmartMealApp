//
//  TestViewController.swift
//  SmartMeal
//
//  Created by Nursat Sakyshev on 13.03.2025.
//

import UIKit
import SkeletonView


class TestViewController: UIViewController, SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    

    func collectionSkeletonView(_ tableView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TestTableViewCell.identifier
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.identifier, for: indexPath) as? TestTableViewCell else { return UITableViewCell()}
        cell.isSkeletonable = true
        if !data.isEmpty {
            cell.myLabel.text = data[indexPath.row]
            cell.myImageView.image = UIImage(systemName: "star")
        }
        return cell
    }
    
    
    var tableView: UITableView!
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = UITableView()
//        tableView.isSkeletonable = true
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: TestTableViewCell.identifier)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            for _ in 0..<30 {
                self.data.append("some Text")
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.showSkeleton(usingColor: .wetAsphalt, transition: .crossDissolve(0.25))
//        tableView.showGradientSkeleton()
    }
}


class TestTableViewCell: UITableViewCell {
    static let identifier = "TestTableViewCell"
    
    let myLabel = UILabel()
    let myImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.isSkeletonable = true
        myLabel.text = "label"
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myLabel.isSkeletonable = true
        myImageView.isSkeletonable = true
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            myImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            myImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            myImageView.heightAnchor.constraint(equalToConstant: 100),
            myImageView.widthAnchor.constraint(equalToConstant: 100),
            
            myLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 20),
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}


