//
//  ListOfCitiesController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 20.04.2023.
//

import Foundation
import UIKit

protocol ListOfCitiesControllerDelegate: AnyObject {
    func changeCoordinatesOnMain(lat: String, lon: String)
}

class ListOfCitiesController: UIViewController {
    
    weak var delegate: ListOfCitiesControllerDelegate?
    var searchListOfCities: [ListOfCitiesModel]? = []
    private let networkService = NetworkService()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewElement()
        setupConstraint()
        setupTableView()
        
    }
    
    private func addNewElement() {
        view.addSubview(tableView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func getListOfCities(city: String) {
        networkService.getListOfCities(for: ListOfCitiesRequest(city: city)) { [weak self] result in
            switch result {
            case let .success(model):
                for i in model {
                    self?.searchListOfCities?.append(ListOfCitiesModel(name: i.name, lat: "\(i.lat)", lon: "\(i.lon)", country: i.country, state: i.state ?? ""))
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        searchListOfCities = []
    }
}

extension ListOfCitiesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchListOfCities?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = searchListOfCities?[indexPath.row]
        cell.textLabel?.text = "\(city?.name ?? ""), \(city?.country ?? ""), \(city?.state ?? "")"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let lat = searchListOfCities?[index].lat ?? ""
        let lon = searchListOfCities?[index].lon ?? ""
        self.delegate?.changeCoordinatesOnMain(lat: lat, lon: lon)
    }
}

extension ListOfCitiesController: UITableViewDelegate {
}

extension ListOfCitiesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        //print(searchText)
        var updateSearchText: String = ""
        for i in searchText {
            let ii = String(i)
            if ii == " " {
                updateSearchText += "-"
            } else {
                updateSearchText += ii
            }
        }
        getListOfCities(city: updateSearchText)
    }
}
