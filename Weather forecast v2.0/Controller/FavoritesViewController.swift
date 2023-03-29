//
//  FavoritesViewController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 28.03.2023.
//

import Foundation
import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    //    func deleteCityFromFavorite(id: FavoritesCellModel?)
    //    func changeCoordinateCity(coordinate: CoordinatesCellModel?)
}

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private enum Constants {
        static let backgroundColor = "D6F0FA"
    }
    
    //MARK: - Properties
    
    private let factoryView = FactoryView()
    private lazy var tableView = factoryView.table
    
    
    //MARK: - Init
    
    //    init(coordinatesCityModel: Array<CityModel?>) {
    //        self.coordinatesCellModel = coordinatesCityModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        return nil
    //    }
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupElements()
        setupConstraints()
        setupTable()
        
        //        let group = DispatchGroup()
        //        coordinatesCellModel.forEach {
        //            group.enter()
        //            self.fetchWeather(lon: "\($0?.lon ?? 0)" , lat: "\($0?.lat ?? 0)") {
        //                group.leave()
        //            }
        //        }
        //
        //        group.notify(queue: .main) {
        //            self.tableView.reloadData()
        //        }
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
    
    //    private func fetchWeather(lon: String, lat: String, completion: @escaping () -> Void) {
    //        service.fetchCurrentWeather(for: CoordinateWeatherSource(lat: lat, lon: lon)) { [weak self] result in
    //            switch result {
    //            case let .success(model):
    //                let favoriteCity = FavoritesCellModel(cityName: model.name, temperature: model.main.temp, description: model.weather.first?.description ?? "", lat: "\(model.coord.lat)", lon: "\(model.coord.lon)", id: model.id)
    //                self?.favoritesCellModel.append(favoriteCity)
    //                completion()
    //            case let.failure(error):
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    
    
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
    }
    
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //favoritesCellModel.count
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        //        let model = favoritesCellModel[indexPath.row]
        //        cell.setup(model: model)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //    let coordinate = CoordinatesCellModel(lat: favoritesCellModel[indexPath.row].lat, lon: favoritesCellModel[indexPath.row].lon, id: favoritesCellModel[indexPath.row].id)
        //    delegate?.changeCoordinateCity(coordinate: coordinate)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            //            self?.delegate?.deleteCityFromFavorite(id: self?.favoritesCellModel[indexPath.row])
            //            self?.favoritesCellModel.remove(at: indexPath.row)
            tableView.reloadData()
        }
        actionDelete.image = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        actionDelete.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
