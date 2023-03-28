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
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let heightDivider: CGFloat = 3.3
        static let titleViewWidthConstant: CGFloat = 34
    }
    
    //MARK: - Properties
    
    private let factoryView = FactoryView()
    private lazy var tableView = factoryView.table
    
     let viewForNavigationBar = ViewForNavigationBar()

    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupElements()
        setupConstraints()
        setupTable()
        setupSettingsNavigationBar()
        definesPresentationContext = true // позволяет показать navigationBar поверх SearchList
    }
    
    private func setupElements() {
        view.addSubview(tableView)
    }
    
    /// Добавление viewForNavigationBar с кнопками на navigationBar
    private func setupSettingsNavigationBar() {
        navigationItem.titleView = viewForNavigationBar
        navigationItem.titleView?.widthAnchor.constraint(equalToConstant: view.bounds.width - Constants.titleViewWidthConstant).isActive = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ForecastTodayCell.self, forCellReuseIdentifier: ForecastTodayCell.identifier)
        tableView.register(DetailedForecastTodayCell.self, forCellReuseIdentifier: DetailedForecastTodayCell.identifier)
        tableView.register(Forecast5DaysCell.self, forCellReuseIdentifier: Forecast5DaysCell.identifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            cellSecond.delegate = self
            return cellSecond
        } else {
            guard let cellThird = tableView.dequeueReusableCell(withIdentifier: Forecast5DaysCell.identifier, for: indexPath) as? Forecast5DaysCell else {
                return UITableViewCell()
            }
            return cellThird
        }
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //высота ячейки (чтобы не схлопывалась коллекция)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return Constants.screenHeight / Constants.heightDivider
        }
        return UITableView.automaticDimension
    }
}

//MARK: - extension: DetailedForecastTodayCellDelegate

extension ViewController: DetailedForecastTodayCellDelegate {
    func showDetailedViewController() {
        let controller = DetailedViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
