//
//  FactoryView.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 14.03.2023.
//

import Foundation
import UIKit

/// Фабрика View которые можно использовать в ViewController
class FactoryView {
   
    private enum Constants {
        static let backgroundColor = "D6F0FA"
    }
    
    let table: UITableView = {
        var table = UITableView()
        table.backgroundColor = UIColor(hex: Constants.backgroundColor)
        table.separatorStyle = .none
//        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
}
