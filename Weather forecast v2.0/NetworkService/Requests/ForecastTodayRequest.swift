//
//  ForecastTodayRequest.swift
//  Weather forecast v2.0
//
//  Created by Виталий Троицкий on 18.04.2023.
//

import Foundation

struct ForecastTodayRequest: RequestApiProtocol {
    
    let lat: String
    let lon: String
    var url: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&appid=\(token)")!
    }
    
    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }
}
