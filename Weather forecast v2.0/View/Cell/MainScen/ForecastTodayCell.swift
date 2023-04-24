//
//  ForecastTodayCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 15.03.2023.
//

import UIKit

/// Ячейка с текущем прогнозом на главной сцене
final class ForecastTodayCell: UITableViewCell {
    
    private enum Constants {
        static let alphaCityAndDegrees: CGFloat = 0.8
        static let alphaDayAndDate: CGFloat = 0.6
        static let alphaImageWind: CGFloat = 0.2
        static let backgroundColor = "D6F0FA"
        static let gradientColorOne = "69E1D5"
        static let gradientColorTwo = "00ADFF"
        static let cornerRadiusView: CGFloat = 40
        static let viewBackgroundTopConstant: CGFloat = 15
        static let viewBackgroundLeadingConstant: CGFloat = 20
        static let viewBackgroundTrailingConstant: CGFloat = -20
        static let imageWeatherTopConstant: CGFloat = -25
        static let imageWeatherLeadingConstant: CGFloat = 25
        static let imageWeatherWidthConstant: CGFloat = 0.4
        static let titlCityLeadingConstant: CGFloat = 30
        static let dayOfTheWeekLeadingConstant: CGFloat = 30
        static let dayOfTheWeekTrailingConstant: CGFloat = -5
        static let dayOfTheWeekBottomConstant: CGFloat = -20
        static let degreesLabelTopConstant: CGFloat = 15
        static let degreesLabelTrailingConstant: CGFloat = -30
        static let imageWindTrailingConstant: CGFloat = 9
        static let imageWindBottomConstant: CGFloat = 35
        static let imageWindWidthConstant: CGFloat = 1/6
        static let imageWind = "сильный ветер"
        static let titleCityFontSize: CGFloat = 20
        static let dayAndDateFontSize: CGFloat = 32
        static let degreesFontSize: CGFloat = 5.8
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let viewBackground: GradientView = {
        let view = GradientView(colors: [UIColor(hex: Constants.gradientColorOne), UIColor(hex: Constants.gradientColorTwo)], cornerRadius: Constants.cornerRadiusView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titlCity: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.titleCityFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaCityAndDegrees
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let dayOfTheWeek: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.dayAndDateFontSize)
        label.alpha = Constants.alphaDayAndDate
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = Constants.alphaDayAndDate
        label.adjustsFontSizeToFitWidth = true
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.dayAndDateFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degreesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaCityAndDegrees
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.degreesFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageWind: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: Constants.imageWind)
        imageView.image = image
        imageView.alpha = Constants.alphaImageWind
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupSubviews()
        setupConstraints()
        setupHuggingPriority()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSubviews() {
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(imageWeather)
        viewBackground.addSubview(titlCity)
        viewBackground.addSubview(dayOfTheWeek)
        viewBackground.addSubview(dateLabel)
        viewBackground.addSubview(degreesLabel)
        viewBackground.addSubview(imageWind)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewBackgroundTopConstant),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.viewBackgroundLeadingConstant),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.viewBackgroundTrailingConstant),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageWeather.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: Constants.imageWeatherTopConstant),
            imageWeather.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: Constants.imageWeatherLeadingConstant),
            imageWeather.widthAnchor.constraint(equalTo: viewBackground.widthAnchor, multiplier: Constants.imageWeatherWidthConstant),
            imageWeather.heightAnchor.constraint(equalTo: imageWeather.widthAnchor),
            
            titlCity.topAnchor.constraint(equalTo: imageWeather.bottomAnchor),
            titlCity.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: Constants.titlCityLeadingConstant),
            titlCity.trailingAnchor.constraint(equalTo: imageWind.leadingAnchor),
            
            dayOfTheWeek.topAnchor.constraint(equalTo: titlCity.bottomAnchor),
            dayOfTheWeek.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: Constants.dayOfTheWeekLeadingConstant),
            dayOfTheWeek.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: Constants.dayOfTheWeekTrailingConstant),
            dayOfTheWeek.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: Constants.dayOfTheWeekBottomConstant),
            
            dateLabel.topAnchor.constraint(equalTo: titlCity.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: imageWind.leadingAnchor),
            
            degreesLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: Constants.degreesLabelTopConstant),
            degreesLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: Constants.degreesLabelTrailingConstant),
            
            imageWind.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -UIScreen.main.bounds.width / Constants.imageWindTrailingConstant),
            imageWind.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -UIScreen.main.bounds.width / Constants.imageWindBottomConstant),
            imageWind.widthAnchor.constraint(equalTo: viewBackground.widthAnchor, multiplier: Constants.imageWindWidthConstant),
            imageWind.heightAnchor.constraint(equalTo: imageWind.widthAnchor)
        ])
    }
    
    private func setupHuggingPriority() {
        dayOfTheWeek.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setup(model: ForecastCityModel?) {
        titlCity.text = model?.firstSectionModel?.city
        degreesLabel.text = model?.firstSectionModel?.temp
        dayOfTheWeek.text = selectionDayOfWeek(valueT: model?.firstSectionModel?.timeZone ?? 0)
        dateLabel.text = selectionDate(valueT: model?.firstSectionModel?.timeZone ?? 0)
        imageWeather.image = UIImage(named: updateImageMain(icon: model?.firstSectionModel?.weatherIcon ?? ""))
    }
    
    /// Преобразуем день недели из unix, UTC в дату
    /// - Parameter valueT: день недели в unix
    /// - Returns: День недели (прописью) в формате String
    func selectionDayOfWeek(valueT: Int) -> String {
        let dateFormatter = DateFormatter()
        let value = valueT
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: value) as TimeZone
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: Date())
        return weekDay.capitalized
    }
    
    /// Преобразуем день недели и месяц из unix, UTC в дату
    /// - Parameter valueT: дата в unix
    /// - Returns: День недели и месяц (в цифрах) в формате String
    func selectionDate(valueT: Int) -> String {
        let dateFormatter = DateFormatter()
        let value = valueT
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: value) as TimeZone
        dateFormatter.dateFormat = "dd/MM"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
    func updateImageMain(icon: String) -> String {
        let value = icon
        switch value {
        case "01d": return "clearDay"
        case "01n": return "clearNight"
        case "02d": return "fewCloudsDay"
        case "02n": return "fewCloudsNight"
        case "03d", "03n": return "scatteredClouds"
        case "04d", "04n": return "clouds"
        case "09d", "09n": return "drizzle"
        case "10d", "10n": return "heavyRain"
        case "11d", "11n": return "thunderstorm"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "mist"
        default: return "clearDay"
        }
    }
}
