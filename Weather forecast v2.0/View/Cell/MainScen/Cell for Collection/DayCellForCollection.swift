//
//  DayCellForCollection.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 21.03.2023.
//

import Foundation
import UIKit

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
        static let infFontSize: CGFloat = 20
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
        let lable = UILabel()
        lable.textColor = .black
        lable.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.dayWeekFontSize)
        lable.adjustsFontSizeToFitWidth = true
        lable.text = "ПН"
        lable.alpha = Constants.dayWeekAlfa
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let date: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.dateFontSize)
        lable.adjustsFontSizeToFitWidth = true
        lable.text = "02/11"
        lable.alpha = Constants.dateAlfa
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let degrees: UILabel = {
        let lable = UILabel()
        lable.text = "7"
        lable.textColor = .black
        lable.adjustsFontSizeToFitWidth = true
        lable.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.degreesFontSize)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let inf: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.text = "info"
        lable.adjustsFontSizeToFitWidth = true
        lable.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.infFontSize)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
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
            
            inf.topAnchor.constraint(equalTo: degrees.bottomAnchor),
            inf.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            inf.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.infBottomConstant),
        ])
        dayWeek.setContentHuggingPriority(.defaultHigh, for: .vertical)
        date.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageWeather.setContentHuggingPriority(.defaultHigh, for: .vertical)
        degrees.setContentHuggingPriority(.defaultLow, for: .vertical)
        inf.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
