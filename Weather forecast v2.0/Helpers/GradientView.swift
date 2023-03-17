//
//  GradientView.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 16.03.2023.
//

import UIKit


/// Градиент цвета. Используется в ячейке ForecastTodayCell
class GradientView: UIView {

    private enum Constatns {
        static let cornerRadius: CGFloat = 40
        static let startPoint: CGPoint = CGPoint(x: 0, y: 0)
        static let endPoint: CGPoint = CGPoint(x: 0.6, y: 1)
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
