//
//  ForecastTodayCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 15.03.2023.
//

import UIKit

final class ForecastTodayCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private enum Constants {
        static let alphaCityAndDegrees: CGFloat = 0.8
        static let alphaDayAndDate: CGFloat = 0.6
        static let alphaImageWind: CGFloat = 0.2
        static let backgroundColor = "D6F0FA"
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
    }

    let viewBackground: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageWeather: UIImageView = {
       let imageView = UIImageView()
        let image = UIImage(named: "fewCloudsDay")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titlCity: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Санкт-Петербург"
        //label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 20)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaCityAndDegrees
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var dayOfTheWeek: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Понедельник"
        label.adjustsFontSizeToFitWidth = true
//        label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 32)
        label.alpha = Constants.alphaDayAndDate
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "16/03"
        label.textColor = .white
        label.alpha = Constants.alphaDayAndDate
        label.adjustsFontSizeToFitWidth = true
//        label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let degreesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "9"
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaCityAndDegrees
//        label.font = .AAvanteBsExtraBold(size: UIScreen.main.bounds.width / 5.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageWind: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "сильный ветер")
        imageView.image = image
        imageView.alpha = Constants.alphaImageWind
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
}
