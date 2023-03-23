//
//  Forecast5DaysCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 21.03.2023.
//

import Foundation
import UIKit

class Forecast5DaysCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum Constants {
        static let backgroundColor = "D6F0FA"
        static let lineSpacing: CGFloat = 12
        static let indentItems: CGFloat = 25
        static let collectionViewTopConstant: CGFloat = 25
        static let collectionViewBottomConstant: CGFloat = -25
        static let widthDividerItems: CGFloat = 5
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionView)
        collection.backgroundColor = UIColor(hex: Constants.backgroundColor)
        collectionView.scrollDirection = .horizontal
        collection.register(DayCellForCollection.self, forCellWithReuseIdentifier: DayCellForCollection.identifier)
        collectionView.minimumLineSpacing = Constants.lineSpacing //минимальное расстояние между items коллекции
        collectionView.sectionInset = UIEdgeInsets(top: .zero, left: Constants.indentItems, bottom: .zero, right: Constants.indentItems) // отступ элементов от края коллекции
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hex: Constants.backgroundColor)
        setupElements()
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        selectionStyle = .none
        collectionView.showsHorizontalScrollIndicator = false
        selectItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.collectionViewTopConstant),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.collectionViewBottomConstant)
        ])
    }
    
    /// Выбор Item по дефолту
    private func selectItem() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
    
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return test?.count ?? 0
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCellForCollection.identifier, for: indexPath) as! DayCellForCollection
//        let dodo = test?[indexPath.row]
//        myCell.setup(model: dodo)
        return myCell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    // возвращает размеры Items коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / Constants.widthDividerItems, height: collectionView.frame.height)
    }
}
