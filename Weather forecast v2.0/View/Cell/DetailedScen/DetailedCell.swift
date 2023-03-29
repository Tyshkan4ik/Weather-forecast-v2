//
//  DetailedCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 24.03.2023.
//

import Foundation
import UIKit

/// Ячейка для таблицы на DetailedViewController
class DetailedCell: UITableViewCell {
    
    private enum Constants {
        static let symbolWidthConstant: CGFloat = 50
        static let separetorTopConstant: CGFloat = 8
        static let separetorWidthConstant: CGFloat = 0.4
        static let separetorBottomConstant: CGFloat = -8
        static let descriptionLabelLeadingConstant: CGFloat = 10
        static let valueLabelTopConstant: CGFloat = 10
        static let valueLabelWidthConstant: CGFloat = 160
        static let valueLabelBottomConstant: CGFloat = -10
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let symbol: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание показателя"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "6:00"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupElements()
        setupConstraints()
        selectionStyle = .none // отменить выделение ячейки
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        contentView.addSubview(symbol)
        contentView.addSubview(separator)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(valueLabel)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            symbol.widthAnchor.constraint(equalToConstant: Constants.symbolWidthConstant),
            
            separator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.separetorTopConstant),
            separator.leadingAnchor.constraint(equalTo: symbol.trailingAnchor),
            separator.widthAnchor.constraint(equalToConstant: Constants.separetorWidthConstant),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: Constants.separetorBottomConstant),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: Constants.descriptionLabelLeadingConstant),
            descriptionLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.valueLabelTopConstant),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: Constants.valueLabelWidthConstant),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.valueLabelBottomConstant)
        ])
    }
    
    //    func setup(model: [MoreCellModel.Row]?) {
    //        descriptionLabel.text = model?.first?.titl
    //        valueLabel.text = model?.first?.valueTitle
    //        symbol.image = model?.first?.icon
    //    }
}

