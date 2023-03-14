//
//  ViewController.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 14.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let backgroundColor = "D6F0FA"
    }
    
//MARK: - Properties
    
    private let factoryView = FactoryView()
    
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
          
        ])
    }
    
}
