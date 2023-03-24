//
//  ItemViewforStackFromDetailedCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 17.03.2023.
//

import UIKit

/// View для stackView используемые в DetailedForecastTodayCell
class ItemViewforStackFromDetailedCell: UIView {
    
    private enum Constants {
        static let numberOfLines = 0
        static let titleTopConstant: CGFloat = 5
    }
    
    //MARK: - Properties
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "person")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titl: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = Constants.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueTitl: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.numberOfLines = Constants.numberOfLines
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElement()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Methods
    
    private func setupElement() {
        addSubview(image)
        addSubview(titl)
        addSubview(valueTitl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            image.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            titl.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.titleTopConstant),
            titl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titl.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueTitl.topAnchor.constraint(equalTo: titl.bottomAnchor),
            valueTitl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueTitl.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueTitl.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueTitl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        image.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
