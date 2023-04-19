//
//  DetailedForecastTodayModel.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation
import UIKit

struct DetailedForecastTodayModel {
    let element1: ElementModel
    let element2: ElementModel
    let element3: ElementModel
    let element4: ElementModel
    let element5: ElementModel
    let element6: ElementModel
    
    struct ElementModel {
        //let title: String
        let value: String
        //let image: UIImage?
    }
}
