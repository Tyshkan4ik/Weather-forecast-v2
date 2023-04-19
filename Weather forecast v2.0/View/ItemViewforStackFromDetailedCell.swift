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
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
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
        addSubview(title)
        addSubview(valueTitl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            image.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.titleTopConstant),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueTitl.topAnchor.constraint(equalTo: title.bottomAnchor),
            valueTitl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueTitl.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueTitl.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueTitl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        image.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
   
    func setup(model: DetailedForecastTodayModel.ElementModel?) {
//        image.image = model?.image
//        titl.text = model?.title.firstUppercased
        valueTitl.text = model?.value//.firstUppercased
    }
}
