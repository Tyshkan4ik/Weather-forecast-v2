//
//  ViewController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 14.03.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let backgroundColor = "D6F0FA"
    }
    
    //MARK: - Properties
    
    private let factoryView = FactoryView()
    
    private lazy var tableView = factoryView.table
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupSubviews()
        setupConstraints()
        setupTable()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastTodayCell.self, forCellReuseIdentifier: ForecastTodayCell.identifier)
        tableView.register(DetailedForecastTodayCell.self, forCellReuseIdentifier: DetailedForecastTodayCell.identifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cellFirst = tableView.dequeueReusableCell(withIdentifier: ForecastTodayCell.identifier, for: indexPath) as? ForecastTodayCell else {
                return UITableViewCell()
            }
            return cellFirst
        } else if indexPath.section == 1 {
            guard let cellSecond = tableView.dequeueReusableCell(withIdentifier: DetailedForecastTodayCell.identifier, for: indexPath) as? DetailedForecastTodayCell else {
                return UITableViewCell()
            }
            return cellSecond
        } else {
            var cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            var configuration = cell.defaultContentConfiguration()
            configuration.text = "Hello"
            cell.contentConfiguration = configuration
            return cell
        }
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
