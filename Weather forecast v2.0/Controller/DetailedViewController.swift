//
//  DetailedViewController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 24.03.2023.
//

import UIKit

class DetailedViewController: UIViewController, UITableViewDataSource {
    
    private enum Constants {
        static let backgroundColor = "D6F0FA"
    }
    
    //MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(hex: Constants.backgroundColor)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupElements()
        setupConstraints()
        setupTable()
    }
    
    private func setupElements() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTable() {
        tableView.dataSource = self
        tableView.register(DetailedCell.self, forCellReuseIdentifier: DetailedCell.identifier)
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // moreCellModel?.row.count ?? 0
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedCell.identifier, for: indexPath) as? DetailedCell else {
            return UITableViewCell()
        }
//        let test = moreCellModel?.row[indexPath.row]
//        cell.setup(model: test)
        return cell
    }
}
    


