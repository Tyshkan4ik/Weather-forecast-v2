//
//  ForecastTodayModel.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation

struct ForecastTodayResponce: Decodable {
    let coord: Coord
    let weather: [Weather]
    let timezone: Int
    let name: String
    let main: Main
    let sys: Sys
    let wind: Wind
    let clouds: Clouds
    let id: Int
    
    
    enum CodingKeys: String, CodingKey {
        case coord, weather, timezone, name, main, sys, wind, clouds, id
    }
    
    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
        let seaLevel: Int?
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
        }
    }
    
    struct Sys: Decodable {
        let sunrise: Double
        let sunset: Double
    }
    
    struct Wind: Decodable {
        let speed: Double
        let gust: Double?
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
}
