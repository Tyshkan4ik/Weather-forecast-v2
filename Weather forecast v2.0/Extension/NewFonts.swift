//
//  NewFonts.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 16.03.2023.
//

import Foundation
import UIKit

// добавление нового шрифта, используется в ячейке ForecastTodayCell
extension UIFont {
    static func AAvanteBsExtraBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "AAvanteBsExtraBold", size: size)
    }
    static func AAvanteBsExtraBold() -> UIFont? {
        return UIFont(name: "AAvanteBsExtraBold", size: 17)
    }
}
