//
//  ListOfCitiesResponce.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 20.04.2023.
//

import Foundation

struct ListOfCitiesResponce: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
