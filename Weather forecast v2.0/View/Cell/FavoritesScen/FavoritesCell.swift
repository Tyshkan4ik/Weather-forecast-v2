//
//  FavoritesCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 28.03.2023.
//

import Foundation
import UIKit

/// Ячейка для таблицы на FavoritesViewController
class FavoritesCell: UITableViewCell {
    
    private enum Constants {
        static let gradientColorOne = "69E1D5"
        static let gradientColorTwo = "00ADFF"
        static let cornerRadiusView: CGFloat = 15
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let cityLabelFontSize: CGFloat = 20
        static let alphaLabel: CGFloat = 0.8
        static let degreesFontSize: CGFloat = 12
        static let infoLabelFontSize: CGFloat = 40
        static let viewBackgroundTopConstant: CGFloat = 10
        static let leadingConstant: CGFloat = 20
        static let trailingConstant: CGFloat = -20
        static let infoLabelBottomConstant: CGFloat = -10
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var coordinatesLat: Double?
    var coordinatesLon: Double?
    
    private let viewBackground: GradientView = {
        var view = GradientView(colors: [UIColor(hex: Constants.gradientColorOne), UIColor(hex: Constants.gradientColorTwo)], cornerRadius: Constants.cornerRadiusView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.cityLabelFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degrees: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.degreesFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.infoLabelFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.alpha = Constants.alphaLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
        setupConstraints()
        backgroundColor = .clear
        // отменить выделение ячейки
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(cityLabel)
        viewBackground.addSubview(degrees)
        viewBackground.addSubview(infoLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewBackgroundTopConstant),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingConstant),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingConstant),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: Constants.leadingConstant),
            cityLabel.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor),
            
            degrees.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor),
            degrees.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: Constants.trailingConstant),
            degrees.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: degrees.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: degrees.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: Constants.infoLabelBottomConstant)
        ])
    }
    
    func setup(model: FavoritesCityModel?) {
        cityLabel.text = model?.cityName
        degrees.text = String(format: "%0.1f", model?.temperature ?? 0) + "°"
        infoLabel.text = model?.description
    }
}
