//
//  ViewForNavigationBar.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 24.03.2023.
//

import Foundation
import UIKit

/// View для NavigationBar
class ViewForNavigationBar: UIView {
    
    private enum Constants {
        static let favoritesButtonLeadingConstant: CGFloat = 15
        static let addToFavoritesButtonTrailingConstant: CGFloat = -15
        static let favoritesButtonName = "menu"
        static let addToFavoritesButtonName = "star"
        static let addToFavoritesWidthDivider: CGFloat = 17
    }
    
    //MARK: - Properties
    
    let favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.favoritesButtonName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addToFavoritesButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / Constants.addToFavoritesWidthDivider, weight: .medium, scale: .default)
        let image = UIImage(systemName: Constants.addToFavoritesButtonName, withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(favoritesButton)
        addSubview(addToFavoritesButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(equalTo: topAnchor),
            favoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            favoritesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.favoritesButtonLeadingConstant),
            favoritesButton.widthAnchor.constraint(equalTo: favoritesButton.heightAnchor),
            
            addToFavoritesButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.addToFavoritesButtonTrailingConstant),
        ])
    }
}
