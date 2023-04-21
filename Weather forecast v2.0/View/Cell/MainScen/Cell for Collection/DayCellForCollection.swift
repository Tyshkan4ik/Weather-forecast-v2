//
//  DayCellForCollection.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 21.03.2023.
//

import Foundation
import UIKit

/// Ячейка коллекции расположенной в Forecast5DaysCell
class DayCellForCollection: UICollectionViewCell {
    
    private enum Constants {
        static let gradientColorOne = "69E1D5"
        static let gradientColorTwo = "00ADFF"
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let dayWeekFontSize: CGFloat = 20
        static let dayWeekAlfa: CGFloat = 0.7
        static let dateFontSize: CGFloat = 25
        static let dateAlfa: CGFloat = 0.5
        static let degreesFontSize: CGFloat = 15
        static let infFontSize: CGFloat = 43
        static let itemCornerRadius: CGFloat = 35
        static let dayWeekTopConstant: CGFloat = 20
        static let imageWeatherTopConstant: CGFloat = 5
        static let imageWeatherLeadingConstant: CGFloat = 5
        static let imageWeatherMultiplier: CGFloat = 0.89
        static let degreesTopConstant: CGFloat = 5
        static let infBottomConstant: CGFloat = -20
        
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundView = GradientViewForCollectionCell(colors: [UIColor(hex: Constants.gradientColorOne), UIColor(hex: Constants.gradientColorTwo)])
            }
            else {
                self.backgroundView = UIView()
            }
        }
    }
    
    private let imageWeather: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "fewCloudsDay")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dayWeek: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.dayWeekFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.dayWeekAlfa
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let date: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.dateFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.dateAlfa
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degrees: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.degreesFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let inf: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "info"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = Constants.dayWeekAlfa
        label.adjustsFontSizeToFitWidth = true
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.infFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = Constants.itemCornerRadius
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        contentView.addSubview(imageWeather)
        contentView.addSubview(dayWeek)
        contentView.addSubview(date)
        contentView.addSubview(degrees)
        contentView.addSubview(inf)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayWeek.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.dayWeekTopConstant),
            dayWeek.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            date.topAnchor.constraint(equalTo: dayWeek.bottomAnchor),
            date.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageWeather.topAnchor.constraint(equalTo: date.bottomAnchor, constant: Constants.imageWeatherTopConstant),
            imageWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.imageWeatherLeadingConstant),
            imageWeather.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.imageWeatherMultiplier),
            imageWeather.heightAnchor.constraint(equalTo: imageWeather.widthAnchor),
            
            degrees.topAnchor.constraint(equalTo: imageWeather.bottomAnchor, constant: Constants.degreesTopConstant),
            degrees.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            inf.topAnchor.constraint(equalTo: degrees.bottomAnchor, constant: 5),
            inf.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            inf.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.infBottomConstant),
            inf.widthAnchor.constraint(equalToConstant: contentView.bounds.width)
        ])
        dayWeek.setContentHuggingPriority(.defaultHigh, for: .vertical)
        date.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageWeather.setContentHuggingPriority(.defaultHigh, for: .vertical)
        degrees.setContentHuggingPriority(.defaultLow, for: .vertical)
        inf.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func setup(model: Forecast5DaysModel?) {
        degrees.text = String(format: "%0.1f", model?.temp ?? 0)
        imageWeather.image = UIImage(named: updateImageMain(icon: model?.icon ?? ""))
        dayWeek.text = transformTimeUnix(unix: model?.date ?? 0, timeZone: model?.timeZone ?? 0)
        date.text = transformTimeUnix2(unix: model?.date ?? 0, timeZone: model?.timeZone ?? 0)
        inf.text = model?.description
//        print(model?.description ?? "")
    }
    
    /// Преобразуем время из unix, UTC с учетом часового пояса
    /// - Parameters:
    ///   - unix: Время в unix
    ///   - timeZone: Часовой пояс
    /// - Returns: Получаем время с учетом часового пояса
    private func transformTimeUnix(unix: Double, timeZone: Int) -> String {
        let date = NSDate(timeIntervalSince1970: unix)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EE"
        dayTimePeriodFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timeZone) as TimeZone?
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    /// Преобразуем время из unix, UTC с учетом часового пояса
    /// - Parameters:
    ///   - unix: Время в unix
    ///   - timeZone: Часовой пояс
    /// - Returns: Получаем время с учетом часового пояса
    private func transformTimeUnix2(unix: Double, timeZone: Int) -> String {
        let date = NSDate(timeIntervalSince1970: unix)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd/MM"
        dayTimePeriodFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timeZone) as TimeZone?
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    func updateImageMain(icon: String) -> String {
        let value = icon
        switch value {
        case "01d":
            return "clearDay"
        case "01n":
            return "clearNight"
        case "02d":
            return "fewCloudsDay"
        case "02n":
            return "fewCloudsNight"
        case "03d", "03n":
            return "scatteredClouds"
        case "04d", "04n":
            return "clouds"
        case "09d", "09n":
            return "drizzle"
        case "10d", "10n":
            return "heavyRain"
        case "11d", "11n":
            return "thunderstorm"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "mist"
        default:
            return "fewCloudsDay"
        }
    }
}
