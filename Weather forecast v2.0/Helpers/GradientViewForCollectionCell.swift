//
//  GradientViewForCollectionCell.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 21.03.2023.
//

import Foundation
import UIKit

/// Градиент цвета. Используется в ячейке DayCellForCollection
class GradientViewForCollectionCell: UIView {
    
    private enum Constatns {
        static let cornerRadius: CGFloat = 30
        static let startPoint: CGPoint = CGPoint(x: 1, y: 0)
        static let endPoint: CGPoint = CGPoint(x: 1, y: 0.5)
    }
    
    let gradient = CAGradientLayer()
    
    init(colors: [UIColor?]) {
        super.init(frame: .zero)
        gradient.cornerRadius = Constatns.cornerRadius
        gradient.startPoint = Constatns.startPoint
        gradient.endPoint = Constatns.endPoint
        gradient.frame = bounds
        gradient.colors = colors.map { $0?.cgColor ?? UIColor.clear.cgColor
        }
        layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
