//
//  ViewController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 14.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let mainViewColor = "D6F0FA"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Constants.mainViewColor)
    }
    
}
