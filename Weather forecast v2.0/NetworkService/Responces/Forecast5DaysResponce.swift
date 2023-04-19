//
//  Forecast5DaysResponce.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation

struct Forecast5DaysResponce: Decodable {
    let city: City
    let list: [List]
    
    struct List: Decodable {
        let dt: Double
        let main: Main
        let dtTxt: String
        let weather: [Weather]
        
        struct Main: Decodable {
            let temp: Double
        }
        enum CodingKeys: String, CodingKey {
            case dt, main, weather
            case dtTxt = "dt_txt"
        }
        
        struct Weather: Decodable {
            let icon: String
            let description: String
        }
    }
    
    struct City: Decodable {
        let coord: Coord
        let name: String
        let timezone: Int
        
        struct Coord: Decodable {
            let lon: Double
            let lat: Double
        }
    }
}
