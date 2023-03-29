//
//  ViewForNavigationBar.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 24.03.2023.
//

import Foundation
import UIKit

/// Делегат вью ViewForNavigationBar с переходом на FavoritesViewController
protocol ViewForNavigationBarDelegate: AnyObject {
    func showFavoritesViewController()
    //func update(_ cell: DetailedCell)
}

/// View для NavigationBar
class ViewForNavigationBar: UIView {
    
    private enum Constants {
        static let favoritesButtonName = "menu"
        static let addToFavoritesButtonName = "star"
        static let addToFavoritesWidthDivider: CGFloat = 17
    }
    
    //MARK: - Properties
    
    weak var delegate: ViewForNavigationBarDelegate?
    
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
    
    lazy var searchBar: UISearchController = {
        let searchList = SearchListOfCitiesController()
        let search = UISearchController(searchResultsController: searchList)
        //searchList.delegate = self
        search.searchResultsUpdater = searchList
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElement()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.addTarget(self, action: #selector(presentFavoritesViewController), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Methods
    
    private func setupElement() {
        addSubview(favoritesButton)
        addSubview(addToFavoritesButton)
        addSubview(searchBar.searchBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(equalTo: topAnchor),
            favoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            favoritesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesButton.widthAnchor.constraint(equalTo: favoritesButton.heightAnchor),
            
            addToFavoritesButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchBar.searchBar.leadingAnchor.constraint(equalTo: favoritesButton.trailingAnchor, constant: 10),
            searchBar.searchBar.trailingAnchor.constraint(equalTo: addToFavoritesButton.leadingAnchor, constant: -10),
            searchBar.searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    /// Открывает DetailedViewController
    @objc
    private func presentFavoritesViewController() {
        delegate?.showFavoritesViewController()
    }
}
