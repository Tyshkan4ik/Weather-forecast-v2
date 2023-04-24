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
        static let conversionHPaInMmHg: Double = 0.75006375541921
    }
    
    //MARK: - Properties
    
    var lon: String?
    var lat: String?
    
    var arraySymbol = ["thermometer", "figure.wave", "", "thermometer.snowflake", "thermometer.sun", "person.wave.2", "humidity", "chevron.compact.up", "wind", "tornado", "smoke"]
    let arrayDescription = ["Температура, C°", "Ощущается как, C°", "Текущая погода", "Минимальная темп., C°", "Максимальная темп., C°", "Атмосферное давление, мм. рт. ст.", "Влажность, %", "Атмосферное давление на уровне моря, мм. рт. ст.", "Скорость ветра, м/с", "Порывы ветра, м/с", "Облачность, %"]
    
    private let networkService = NetworkService()
    private var detailedScenForecastTodayModel: [String]?
    
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
        getForecast(lon: lon ?? "", lat: lat ?? "")
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
    
    /// Получаем данные с сервера погоды и передаем их в модели
    private func getForecast(lon: String, lat: String) {
        networkService.getForecastToday(for: ForecastTodayRequest(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                self?.detailedScenForecastTodayModel = [self?.roundUpToOne(value: model.main.temp) ?? "", self?.roundUpToOne(value: model.main.feelsLike) ?? "", "\(model.weather.first?.description ?? "")", self?.roundUpToOne(value: model.main.tempMin) ?? "", self?.roundUpToOne(value: model.main.tempMax) ?? "", model.main.pressure.conversionHPaInMmHg(), "\(model.main.humidity)", model.main.seaLevel?.conversionHPaInMmHg() ?? "0", "\(model.wind.speed)", "\(model.wind.gust ?? 0)", "\(model.clouds.all)"]
                self?.arraySymbol[2] = self?.transformIconInfoCell(icon: model.weather.first?.icon ?? "") ?? ""
                
            case let .failure(error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func transformIconInfoCell(icon: String) -> String {
        switch icon {
        case "01d": return "sun.max"
        case "01n": return "moon"
        case "02d": return "cloud.sun"
        case "02n": return "cloud.moon"
        case "03d", "03n": return "cloud"
        case "04d", "04n": return "smoke"
        case "09d", "09n": return "cloud.drizzle"
        case "010d": return "cloud.sun.rain"
        case "010n": return "cloud.moon.rain"
        case "11d", "11n": return "cloud.bolt"
        case "13d", "13n": return "snowflake"
        case "50d", "50n": return "aqi.high"
        default: return "cloud"
        }
    }
    
    /// Округляем число после запятой из сотых в десятичные
    /// - Parameter value: Число с сотым значением, Double
    /// - Returns: Число с десчятичным значением после запятой в String
    private func roundUpToOne(value: Double) -> String {
        String(round(10 * value) / 10)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailedScenForecastTodayModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedCell.identifier, for: indexPath) as? DetailedCell else {
            return UITableViewCell()
        }
        if let value = detailedScenForecastTodayModel {
            cell.setup(model: value[indexPath.row], symbol: arraySymbol[indexPath.row], description: arrayDescription[indexPath.row])
        }
        return cell
    }
}
