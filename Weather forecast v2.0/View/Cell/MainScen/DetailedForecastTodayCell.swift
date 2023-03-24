//
//  DetailedForecastTodayCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 17.03.2023.
//

import Foundation
import UIKit

protocol DetailedForecastTodayCellDelegate: AnyObject {
    func showDetailedViewController()
    //func update(_ cell: DetailedCell)
}

/// Ячейка с подробным прогнозом на главной сцене
class DetailedForecastTodayCell: UITableViewCell {
    
    private enum Constants {
        static let backgroundColor = "D6F0FA"
        static let cornerRadiusBackgroundView: CGFloat = 40
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let detailButtonTitle: String = "Подробнее ⟫"
        static let detailButtonFontSize: CGFloat = 23
        static let detailButtonTitleAlpha: CGFloat = 0.5
        static let viewBackgroundTopConstant: CGFloat = 25
        static let viewBackgroundLeadingConstant: CGFloat = 20
        static let viewBackgroundTrailingConstant: CGFloat = -20
        static let detailedButtonTopConstant: CGFloat = 20
        static let detailedButtonLeadingConstant: CGFloat = 20
        static let stackViewOneTopConstant: CGFloat = 20
        static let stackViewTwoTopConstant: CGFloat = 30
        static let stackViewBottomConstant: CGFloat = -20
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    weak var delegate: DetailedForecastTodayCellDelegate?
    
    private let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadiusBackgroundView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailedButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.detailButtonTitle, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .AAvanteBsExtraBold(size: Constants.screenWidth / Constants.detailButtonFontSize)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.alpha = Constants.detailButtonTitleAlpha
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackViewOne: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackViewTwo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let item1 = ItemViewforStackFromDetailedCell()
    private let item2 = ItemViewforStackFromDetailedCell()
    private let item3 = ItemViewforStackFromDetailedCell()
    private let item4 = ItemViewforStackFromDetailedCell()
    private let item5 = ItemViewforStackFromDetailedCell()
    private let item6 = ItemViewforStackFromDetailedCell()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupElements()
        setupConstaints()
        detailedButton.addTarget(self, action: #selector(presentDetailedViewController), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        contentView.addSubview(viewBackground)
        viewBackground.addSubview(detailedButton)
        viewBackground.addSubview(stackViewOne)
        viewBackground.addSubview(stackViewTwo)
        stackViewOne.addArrangedSubview(item1)
        stackViewOne.addArrangedSubview(item2)
        stackViewOne.addArrangedSubview(item3)
        stackViewTwo.addArrangedSubview(item4)
        stackViewTwo.addArrangedSubview(item5)
        stackViewTwo.addArrangedSubview(item6)
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.viewBackgroundTopConstant),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.viewBackgroundLeadingConstant),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.viewBackgroundTrailingConstant),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            detailedButton.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: Constants.detailedButtonTopConstant),
            detailedButton.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: Constants.detailedButtonLeadingConstant),
            
            stackViewOne.topAnchor.constraint(equalTo: detailedButton.bottomAnchor, constant: Constants.stackViewOneTopConstant),
            stackViewOne.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor),
            stackViewOne.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor),
            
            stackViewTwo.topAnchor.constraint(equalTo: stackViewOne.bottomAnchor, constant: Constants.stackViewTwoTopConstant),
            stackViewTwo.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor),
            stackViewTwo.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor),
            stackViewTwo.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: Constants.stackViewBottomConstant)
        ])
    }
    
    /// Открывает DetailedViewController
    @objc
    private func presentDetailedViewController() {
        delegate?.showDetailedViewController()
    }
}
