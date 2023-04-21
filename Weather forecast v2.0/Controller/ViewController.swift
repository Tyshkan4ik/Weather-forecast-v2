//
//  ViewController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 14.03.2023.
//

import UIKit
//import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LocationManagerDelegate {
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let backgroundColor = "D6F0FA"
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let heightDivider: CGFloat = 3.3
        static let titleViewWidthConstant: CGFloat = 34
        static let conversionHPaInMmHg: Double = 0.75006375541921
    }
    
    //MARK: - Properties
    
    private let factoryView = FactoryView()
    private lazy var tableView = factoryView.table
    
    private let viewForNavigationBar = ViewForNavigationBar()
    
    private var location = LocationManager()
    
    private let networkService = NetworkService()
    private var forecastCityModel: ForecastCityModel?
    private var cityModel: CityModel?
    
    var favoritesCityArray: Array<CityModel?> = []
    
    var lon: String?
    var lat: String?
    
    //MARK: - Methods
    
    // TEST
    
    
    //TEST ENDED
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location.delegate = self
        view.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupElements()
        setupConstraints()
        setupTable()
        setupSettingsNavigationBar()
        definesPresentationContext = true // позволяет показать navigationBar поверх SearchList
        forecastCityModel = ForecastCityModel()
        cityModel = CityModel()
        getFavoritesCities()
    }
    
    private func setupElements() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
    }
    
    /// Добавление viewForNavigationBar с кнопками на navigationBar
    private func setupSettingsNavigationBar() {
        navigationItem.titleView = viewForNavigationBar
        navigationItem.titleView?.widthAnchor.constraint(equalToConstant: view.bounds.width - Constants.titleViewWidthConstant).isActive = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        viewForNavigationBar.delegate = self
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
    
    /// Округляем число после запятой из сотых в десятичные
    /// - Parameter value: Число с сотым значением, Double
    /// - Returns: Число с десчятичным значением после запятой в String
    private func roundUpToOne(value: Double) -> String {
        String(round(10 * value) / 10)
    }
    
    /// Получаем данные с сервера погоды и передаем их в модели
    private func getForecast(lon: String, lat: String) {
        let group = DispatchGroup()
        group.enter()
        networkService.getForecastToday(for: ForecastTodayRequest(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                self?.cityModel?.id = model.id
                self?.cityModel?.lat = model.coord.lat
                self?.cityModel?.lon = model.coord.lon
                self?.forecastCityModel?.firstSectionModel = ForecastTodayModel(city: model.name, temp: "\(Int(model.main.temp))°", timeZone: model.timezone, weatherIcon: model.weather.first?.icon ?? "", id: model.id)
                self?.forecastCityModel?.secondSectionModel = DetailedForecastTodayModel(element1: .init(value: self?.transformTimeUnix(unix: model.sys.sunrise, timeZone: model.timezone) ?? ""), element2: .init(value: self?.roundUpToOne(value: model.main.feelsLike) ?? ""), element3: .init(value: self?.transformTimeUnix(unix: model.sys.sunset, timeZone: model.timezone) ?? ""), element4: .init(value: "\(model.wind.speed)"), element5: .init(value: "\(model.wind.gust ?? 0)"), element6: .init(value: self?.conversionHPaInMmHg(hPa: model.main.pressure) ?? ""))
    
            case let .failure(error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        networkService.getForecast5Days(for: Forecast5daysRequest(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                let timeZone = model.city.timezone
                let arrayModel = model.list.filter({
                    let time = self?.transformTimeUnix(unix: $0.dt , timeZone: model.city.timezone) ?? ""
                    return time == "15:00" || time == "14:00" || time == "13:00" || time == "14:30"
                })
                    .map {
                        Forecast5DaysModel(temp: $0.main.temp, icon: $0.weather.first?.icon ?? "", date: $0.dt, timeZone: timeZone, description: $0.weather.first?.description ?? "")
                    }
                self?.forecastCityModel?.thirdSectionModel = arrayModel
                
            case let .failure(error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.checkingFavorites()
        }
    }
    
    
    /// Перевод величины давления из hPa в mmHg
    /// - Parameter hPa: Давление в hPa
    /// - Returns: Давление в mmHg, String
    private func conversionHPaInMmHg(hPa: Int) -> String {
        "\(Int(Double(hPa) * Constants.conversionHPaInMmHg))"
    }
    
    /// Преобразуем время из unix, UTC с учетом часового пояса
    /// - Parameters:
    ///   - unix: Время в unix
    ///   - timeZone: Часовой пояс
    /// - Returns: Получаем время с учетом часового пояса
    private func transformTimeUnix(unix: Double, timeZone: Int) -> String {
        let date = NSDate(timeIntervalSince1970: unix)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        dayTimePeriodFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timeZone) as TimeZone?
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    //MARK: - LocationManagerDelegate
    
    func didLocationUpdate(lon: String, lat: String) {
        getForecast(lon: lon, lat: lat)
        self.lon = lon
        self.lat = lat
        location.locationManager.stopUpdatingLocation()
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
            cellFirst.setup(model: forecastCityModel)
            //print(forecastCityModel)
            return cellFirst
        } else if indexPath.section == 1 {
            guard let cellSecond = tableView.dequeueReusableCell(withIdentifier: DetailedForecastTodayCell.identifier, for: indexPath) as? DetailedForecastTodayCell else {
                return UITableViewCell()
            }
            cellSecond.delegate = self
            cellSecond.setup(model: forecastCityModel?.secondSectionModel)
            return cellSecond
        } else {
            guard let cellThird = tableView.dequeueReusableCell(withIdentifier: Forecast5DaysCell.identifier, for: indexPath) as? Forecast5DaysCell else {
                return UITableViewCell()
            }
            
            cellThird.setup(model: forecastCityModel?.thirdSectionModel)
            return cellThird
        }
    }
    
    /// Выгружаем города из CoreData в массив favoritesCityArray
    private func getFavoritesCities() {
        CoreDataManager.shared.getCities { [weak self] cities in
            guard let self = self else { return }
            self.favoritesCityArray = cities.map { CityModel(favoritesOnOff: $0.trueFalse, id: Int($0.id), lon: $0.lon, lat: $0.lat) }
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            if self.favoritesCityArray.filter({ $0?.id == self.cityModel?.id }).isEmpty {
                let image = UIImage(systemName: "star", withConfiguration: config)
                self.viewForNavigationBar.addToFavoritesButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "star.fill", withConfiguration: config)
                self.viewForNavigationBar.addToFavoritesButton.setImage(image, for: .normal)
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //высота ячейки (чтобы не схлопывалась коллекция)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
//            return Constants.screenHeight / Constants.heightDivider
            return 275
        }
        return UITableView.automaticDimension
    }
    
    // TEST
    
    /// Проверяет есть ли город в избранном, если есть помечает кнопку звездочка
    private func checkingFavorites() {
        if favoritesCityArray.filter( { $0?.id == cityModel?.id } ).isEmpty {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star", withConfiguration: config)
            viewForNavigationBar.addToFavoritesButton.setImage(image, for: .normal)
            forecastCityModel?.favoritesOnOff = false
        } else {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
            viewForNavigationBar.addToFavoritesButton.setImage(image, for: .normal)
            forecastCityModel?.favoritesOnOff = true
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Идет обновление...")
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
    @objc func refresh() {
            location.locationManager.startUpdatingLocation()
    }

    //FINISH
    
    
    
}


//MARK: - extension: DetailedForecastTodayCellDelegate

extension ViewController: DetailedForecastTodayCellDelegate {
    
    func showDetailedViewController() {
        let controller = DetailedViewController()
        controller.lon = self.lon
        controller.lat = self.lat
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - extension: ViewForNavigationBarDelegate

extension ViewController: ViewForNavigationBarDelegate {
    
    
    
    func showFavoritesViewController() {
        let controller = FavoritesViewController(favoritesCity: favoritesCityArray)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    /// Добавляем / Удаляем город в/из избранное. Меняется стиль кнопки при клике. Удаляется или добавляется город в CoreData
    /// - Returns: <#description#>
    func PressedButtonAddToFavoritest() -> String {
        if forecastCityModel?.favoritesOnOff == true {
            forecastCityModel?.favoritesOnOff = false
            favoritesCityArray.removeAll(where: { $0?.id == cityModel?.id })
            CoreDataManager.shared.delete(cityId: cityModel)
            print(favoritesCityArray)
            print(favoritesCityArray.count)
            return "star"
        } else {
            forecastCityModel?.favoritesOnOff = true
            
                favoritesCityArray.append(cityModel)
            
            CoreDataManager.shared.save(city: cityModel)
            print(favoritesCityArray)
            print(favoritesCityArray.count)
            return "star.fill"
        }
    }
    
    /// При выборе города через поиск на главную вью передаются координаты выбраного города и закрывается поиск
    /// - Parameters:
    ///   - lat: lat координата
    ///   - lon: lon координата
    func transferOfCoordinates(lat: String, lon: String) {
        getForecast(lon: lon, lat: lat)
                self.lon = lon
                self.lat = lat
           self.viewForNavigationBar.searchBar.isActive = false
    }
}

//MARK: - extension: FavoritesViewControllerDelegate

extension ViewController: FavoritesViewControllerDelegate {
    
    /// Удаляет город из избранного и CoreData при скролле
    /// - Parameter id: модель города, FavoritesCityModel
    func deleteCityFromFavorite(id: FavoritesCityModel?) {
        if id?.id == forecastCityModel?.firstSectionModel?.id {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star", withConfiguration: config)
            viewForNavigationBar.addToFavoritesButton.setImage(image, for: .normal)
            //cityModel?.favoritesOnOff = false
            forecastCityModel?.favoritesOnOff = false
        }
        let city = favoritesCityArray.filter { $0?.id == id?.id }
        favoritesCityArray.removeAll(where: {$0?.id == id?.id})
        CoreDataManager.shared.delete(cityId: city[0])
    }
    
    /// При клике на город в FavoritesViewController переходит на main экран и показывает погоду для выбранного города
    /// - Parameter coordinate: модель данных
    func changeCoordinateCity(coordinate: FavoritesCityModel?) {
        if cityModel?.id != coordinate?.id {
            getForecast(lon: coordinate?.lon ?? "", lat: coordinate?.lat ?? "")
            lon = coordinate?.lon ?? ""
            lat = coordinate?.lat ?? ""
            navigationController?.popViewController(animated: true)
        }
        if cityModel?.favoritesOnOff == false {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star", withConfiguration: config)
            viewForNavigationBar.addToFavoritesButton.setImage(image, for: .normal)
        }
    }
}

//MARK: - extension: ListOfCitiesControllerDelegate

//extension ViewController: ListOfCitiesControllerDelegate {
//    func changeCoordinatesOnMain(lat: String, lon: String) {
//        print("lat, lon")
//        getForecast(lon: lon, lat: lat)
//        self.lon = String(lon)
//        self.lat = String(lat)
//    }
//    
//
//}
